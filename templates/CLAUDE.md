# ML Project Context

## Project Information
- **Name**: [Project Name]
- **Purpose**: [Brief description of what this project does]
- **Repository**: [Repository location]
- **Main Branch**: [Branch name, e.g., main]

## Environment Setup
- **Platform**: RunPod
- **Container**: [Container type, e.g., PyTorch/TensorFlow version]
- **Persistent Storage**: /workspace
- **Key Directories**:
  - Models: [Path to model storage]
  - Data: [Path to datasets]
  - Outputs: [Path to generated outputs]

## Development Workflow
1. Create feature branches from main
2. Implement changes with thorough error handling
3. Test on RunPod environment
4. Create PRs with detailed descriptions

## Key Files and Components
- **[File 1]**: [Description of purpose/functionality]
- **[File 2]**: [Description of purpose/functionality]
- **[Directory 1]**: [Description of contents/purpose]

## Code Style and Conventions
- Use consistent error handling patterns
- Follow PEP 8 for Python code
- Document functions with docstrings
- Handle paths consistently (use Path from pathlib)

## Typical Tasks
- Model training configuration
- Data preprocessing pipelines
- Results visualization
- Hyperparameter optimization

## Common Issues and Solutions
- **[Issue 1]**: [Solution approach]
- **[Issue 2]**: [Solution approach]

## Security Considerations
- Validate all user inputs
- Use environment variables for sensitive configuration
- Don't hardcode credentials
- Escape file paths properly

## Performance Optimization
- Use batched processing where possible
- Implement proper GPU memory management
- Consider RunPod's persistent storage access patterns
- Optimize large file operations

## Future Development Plans
- [Planned feature 1]
- [Planned feature 2]
