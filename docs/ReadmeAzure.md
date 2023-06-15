<summary>Table of Contents</summary>

- [Prequirements](#prequirements)
- [Configuration](#configuration)
- [Installation](#installation)

</details>

---
### Prequirements

To implement this project, you will need the following components and accounts:

- Azure account with a configured Subscription and Application.
- Docker Hub account (or another container registry) to store container images.
- GitHub account for code storage and automation configuration.
- Domain registered with a domain registrar (e.g., Cloudflare) for DNS configuration.

Make sure you have all the required accounts and components for a successful project implementation.

### Configuration

First, you need to configure the secret in repo:

- `AZURE_CLIENT_ID`: AZURE_CLIENT_ID.
- `AZURE_CLIENT_SECRET` : AZURE_CLIENT_SECRET.
- `AZURE_SUBSCRIPTION_ID` : Your Azure subscription ID.
- `AZURE_TENANT_ID` : AZURE_TENANT_ID.
- `GH_TOKEN`: Your token with permission on webhook or repo management. ([To create a token, use](https://github.com/settings/tokens))
- `DOCKER_USERNAME`: Your username in Docker Hub.
- `DOCKER_PASSWORD`: Your password in Docker Hub.

Make sure the specified parameters align with your environment and requirements.
### Installation

To deploy WordPress with Tekton, follow these steps:

1. Clone this repository to your local machine:

    ```
    git clone https://github.com/dmonakh/Wordpress-Tekton-atK8s-inAzure.git
    ```

2. Create a new repository on your GitHub account and enable `Read and write permission` in General setting Action in Repo. Check that there is no webhook in the repo, if there is remove.

3. Set up a remote repository for your local repository:

    ```
    git remote set-url origin https://github.com/<your-username>/<your-repo-name>.git
    ```

4. Update the `terraform_azure/variables.tf`, `terraform_azure/providers.tf` and `terraform_azure/scripts/create_storage.sh` with your desired configuration parameters, such as resource group name, location, cluster name, your domain, and storage account name.

5. Create and configure the secrets required for accessing the database and other resources.

6. Update the `terraform_azure/pipeline/triger.yaml` with your repo url and docker image for Tekton, or `terraform_azure/pipeline/clonebuildpush.yaml` with your repo raw.

7. To create a Wordpress initialization image:

  - Update the `terraform_azure/scripts/setup-db-wp.sh` with your desired wordpress site data, in the url box, specify your domain, in the dbpass, specify root password and keep him. (If you need any necessary themes or     plugins, specify them in this script.)
  - Update the `terraform_azure/Dockerfile` in the ENV PASSWORD box, specify the root password you used on the last step. 

8. Update the `terraform_azure/Deploy.yml`, be sure to use a password like in last step, сhange the name for your image.

9. Enable GitHub Actions in your repository by creating a `.github/workflows` directory and copying the `TerraformAzure.yml` file from this repository:

    ```
    mkdir -p .github/workflows
    cp Wordpress-Tekton-atK8s-inAzure/.github/workflows/TerraformAzure.yml .github/workflows/TerraformAzure.yml
    ```
10. Update the `.github/workflows/TerraformAzure.yml` with your env.

11. Commit `init` and push all the changes to the repository.

12. GitHub Actions will automatically trigger the pipeline to deploy the infrastructure in GCP.

13. Wait for the pipeline to complete successfully to ensure the infrastructure is created successfully.

---

### After successfully completing these steps, revert to the main [Documentation](/README.md) in step Usage.