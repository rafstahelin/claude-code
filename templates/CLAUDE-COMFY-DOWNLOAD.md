# ComfyUI Download Project Context

## Project Information
- **Name**: comfy-download
- **Purpose**: ComfyUI workflow and output synchronization
- **Repository**: https://github.com/rafstahelin/comfy-download
- **Feature Branch**: feature/command-cleanup

## Environment Setup
- **Platform**: RunPod
- **Container**: ML environment with ComfyUI
- **Persistent Storage**: /workspace
- **Key Directories**:
  - `/workspace/comfy-download/`: Main project code
  - `/workspace/ComfyUI/`: ComfyUI installation

## Development Focus
Current work is focused on the Command System Cleanup project, which includes:
- Reorganized command structure
- Enhanced sync management
- Improved setup and documentation
- Better time zone handling

## Key Files and Components
- **dl-manager.sh**: Main command dispatcher
- **bisync_comfyui.sh**: Synchronization handler
- **custom_sync.sh**: Custom sync operations
- **setup.sh**: Environment setup script
- **README.md**: Documentation

## Command System Structure
The improved command structure organizes commands into logical categories:
- **Core Commands**: help, status, start, stop
- **Manual Operations**: backup, run, checkconfig, report
- **Sync Commands**: sync (with workflow, comfy, nodes options)

## Current Testing Checklist
- Initial Setup:
  - Checkout feature branch
  - Make scripts executable
  - Run setup
  - Source bashrc
- Core Commands
- Sync Commands
- Other Commands
- Edge Cases

## Time Zone Improvements
Instead of hardcoding "Panama" time, implement better approach:
- Detect user's local time zone
- Use generic time zone display format
- Add time zone name to output

## Security Considerations
- Validate all user inputs
- Use proper quoting for all variables
- Replace hardcoded paths with environment variables
- Implement process safety with PID files and mutex locking

## Final Merge Steps
- Address issues found during testing
- Update documentation
- Create PR summary
- Merge to main when tests pass

## Future Improvements
- Add support for custom time zone configuration
- Enhanced error reporting and recovery
- Config file for customizing sync directories
- Better visualization of sync status and progress
