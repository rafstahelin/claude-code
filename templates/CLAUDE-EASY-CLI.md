# Easy CLI Project Context

## Project Information
- **Name**: Easy CLI for SimpleTuner
- **Purpose**: CLI automation for LoRA model training workflows
- **Repository**: https://github.com/rafstahelin/easy
- **Main Branch**: main

## Environment Setup
- **Platform**: RunPod
- **Container**: ML environment with SimpleTuner
- **Persistent Storage**: /workspace
- **Key Directories**:
  - `/workspace/easy/`: Main Easy CLI code
  - `/workspace/simpletuner/`: SimpleTuner installation

## Development Workflow
1. Create feature branches named `feature/{feature-name}`
2. Implement changes with thorough error handling
3. Test on RunPod environment
4. Create PRs with detailed descriptions

## Key Files and Components
- **easy.py**: Main CLI entry point
- **classes/**: Core tool implementations
  - **download_configs.py**: Config downloading tool
  - **validation_grid.py**: Validation grid generator
  - **dataset_grid.py**: Dataset grid generator
  - **lora_mover.py**: Model movement utility
  - **lora_sync.py**: Synchronization tool
- **prompts/**: Template prompts
- **setup.sh**: Environment setup script

## Code Style and UI Conventions
- **Two-Step Config Selection UI Pattern**:
  1. First display unique family names (e.g., "sofia", "phoebe")
  2. After selection, display configs for that family with "all" option first
  - Use consistent styling across tools:
    - Panel Border: blue
    - Panel Title: gold1
    - Numbering: yellow
    - Normal Text: white
    - Tool Header: cyan
    - Success/Warning/Error colors: green/yellow/red

## Error Handling Patterns
- Always validate user input
- Provide clear error messages
- Handle unexpected conditions gracefully
- Offer helpful recovery suggestions

## Common Development Tasks
- Extending the Two-Step UI pattern to new tools
- Implementing post-processing workflows
- Enhancing validation grid generation
- Improving configuration management

## Security Considerations
- Validate all user inputs
- Safely handle file paths
- Use proper quoting for all variables
- Avoid shell injection vulnerabilities

## Performance Optimization
- Optimize operations for RunPod environment
- Consider network and disk I/O patterns
- Handle large files efficiently
- Implement progress indicators for long-running tasks

## Current Development Focus
- Post-processing bundle implementation
- UI consistency across tools
- Enhanced error handling
- Better configuration management
