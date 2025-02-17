// Get current and next build number
let current_build = HEMTT.project().version().build();
let next_build = current_build + 1;

// Update version file with new build number
let version_file = HEMTT_RFS.join("addons/main/script_version.hpp").open_file().read();
version_file.replace(
    `#define BUILD ${current_build}`,
    `#define BUILD ${next_build}`
);
print(HEMTT_RFS.join("addons/main/script_version.hpp"));
HEMTT_RFS.join("addons/main/script_version.hpp").create_file().write(version_file);
