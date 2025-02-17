#include "script_component.hpp"

if (!isServer) exitWith {};

LOG("Starting CPS evaluation...");

[] spawn {
    private _lastTime = time;
    private _windowSize = 1;        // 1 second rolling window
    private _maxSamples = 1000;     // maximum number of samples to store
    private _samples = [];          // array to store [time, delay] pairs
    private _CPS = 0;               // will hold our computed CPS
    private _lastEventTime = time;  // for tracking event timing

    while {true} do {
        private _currentTime = time;
        private _delay = _currentTime - _lastTime;
        _lastTime = _currentTime;

        // Only store positive delays with their timestamps
        if (_delay > 0) then {
            // Remove oldest sample if we're at capacity
            if (count _samples >= _maxSamples) then {
                _samples deleteAt 0;
            };
            _samples pushBack [_currentTime, _delay];
        };

        // Remove samples older than our window size
        private _cutoffTime = _currentTime - _windowSize;
        private _validSamples = _samples select {(_x select 0) > _cutoffTime};

        // Only reassign if we actually removed something
        if (count _validSamples != count _samples) then {
            _samples = _validSamples;
        };

        // Calculate average CPS from samples in window
        if (count _samples > 0) then {
            private _totalDelay = 0;
            {
                _totalDelay = _totalDelay + (_x select 1);
            } forEach _samples;
            private _avgDelay = _totalDelay / (count _samples);
            _CPS = 1 / _avgDelay;
        } else {
            _CPS = 0;  // No samples in window
        };

        // Every second, raise a CBA server event with the CPS value
        if ((_currentTime - _lastEventTime) >= 1) then {
            _lastEventTime = _currentTime;
            private _hashes = [
                [
                    ["profile_name", profileName]
                ],
                [
                    ["cps", _CPS],
                    ["sample_count", count _samples]
                ]
            ];
            TRACE_1("CPS Update",_hashes);
            [QGVAR(cps), _hashes] call CBA_fnc_serverEvent;
        };

        sleep 0.001;  // yield to prevent a busy loop
    };
};
