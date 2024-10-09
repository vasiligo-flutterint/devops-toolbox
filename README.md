# DevOps Toolbox

This Docker setup provides an Ubuntu-based environment with Zsh, Oh My Zsh, starship prompt, AWS CLI v2, kubectl, and other useful tools pre-installed. It allows you to use your local AWS and Kubernetes configurations inside the container.

## Prerequisites

- **Docker** installed on your system.
- For Windows users: Using **PowerShell** to run commands.
- AWS and Kubernetes configurations stored in your local `.aws` and `.kube` directories, respectively.

## How to Build

1. **Open PowerShell** and navigate to the directory containing the `Dockerfile`.

2. Run the following command to build the Docker image:

   ```powershell
   docker build -t devops-toolbox .
   ```

   - This command builds the image and tags it as `devops-toolbox`.
   - The `.` specifies the current directory where the `Dockerfile` is located.

## How to Run

To start a container from the image and enter the Zsh shell, while mounting your AWS and Kubernetes configuration directories:

```powershell
docker run -it `
  -v $env:USERPROFILE\.aws:/home/ubuntu/.aws `
  -v $env:USERPROFILE\.kube:/home/ubuntu/.kube `
  devops-toolbox
```

- **Explanation of the command:**
  - `docker run`: Runs a command in a new container.
  - `-it`: Allocates a pseudo-TTY and keeps STDIN open, useful for interactive sessions.
  - `-v`: Mounts a volume. Here, it mounts your local configuration directories into the container.
    - `$env:USERPROFILE\.aws:/home/ubuntu/.aws`: Maps your local AWS configuration to the container's AWS configuration directory.
    - `$env:USERPROFILE\.kube:/home/ubuntu/.kube`: Maps your local Kubernetes configuration to the container's Kubernetes configuration directory.
  - `devops-toolbox`: The name of the image you built earlier.


## Notes

- **Persisting Data**: Changes made inside the container will be lost when the container is removed. By mounting volumes, you can persist configurations and data.
- **Customizing**: Modify the `Dockerfile` to add more tools or change configurations as per your requirements.
- **Using AWS and kubectl**: With the configurations mounted, you can use `aws` and `kubectl` commands inside the container as if you were on your host machine.

