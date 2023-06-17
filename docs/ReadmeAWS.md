<summary>Table of Contents</summary>

- [Prequirements](#prequirements)
- [Configuration](#configuration)
- [Installation](#installation)

</details>

---
### Prequirements

To implement this project, you will need the following components and accounts:

- AWS account with access to the necessary resources.
- AWS service account with administrator privileges and a key for authentication.
- Docker Hub account (or another container registry) to store container images.
- GitHub account for code storage and automation configuration.
- Domain registered with a domain registrar (e.g., Cloudflare) for DNS configuration.

Make sure you have all the required accounts and components for a successful project implementation.

### Configuration

First, you need to configure the secret in repo:

- `AWS_ACCESS_KEY_ID`: Your access key id for service account.
- `AWS_SECRET_ACCESS_KEY` : Your secret access key for service account.
- `AWS_REGION` : your region.
- `GH_TOKEN`: Your token with permission by webhook or repo management. ([To create a token, use](https://github.com/settings/tokens))
- `DOCKER_USERNAME`: Your username in Docker Hub.
- `DOCKER_PASSWORD`: Your password in Docker Hub.

Make sure the specified parameters align with your environment and requirements.
### Installation

To deploy WordPress with Tekton, follow these steps:

1. Clone this repository to your local machine:

    ```
    git clone https://github.com/itsproutorgua/wordpress-cloud-at-k8s.git
    ```

2. Create a new repository on your GitHub account and enable `Read and write permission` in General setting Action in Repo. Check that there is no webhook in the repo, if there is, remove.

3. Set up a remote repository for your local repository:

    ```
    git remote set-url origin https://github.com/<your-username>/<your-repo-name>.git
    ```

4. Update the `terraform_aws/main.tf`, `terraform_aws/backend.tf` and `terraform_aws/scripts/create-s3.sh` with your desired configuration parameters, such as cluster name, region, your domain and bucket for infrastructure.

5. Create and configure the secrets required for accessing the database and other resources.

6. Update the `terraform_aws/pipeline/triger.yaml` with your repo url and docker image for Tekton, or `terraform_aws/pipeline/clonebuildpush.yaml` with your repo raw.

7. To create a Wordpress initialization image:

  - Update the `terraform_aws/scripts/setup-db-wp.sh` with your desired wordpress site data, in the url box, specify your domain, in the dbpass, specify root password and keep him. (If you need any necessary themes or plugins, specify them in this script.)
  - Update the `terraform_aws/Dockerfile` in the ENV PASSWORD box, specify the root password you used in the last step. 

8. Update the `terraform_aws/Deploy.yml`, be sure to use a password like in the last step, change the name for your image.

9. Enable GitHub Actions in your repository by creating a `.github/workflows` directory and copying the `TerraformAWS.yml` file from this repository:

    ```
    mkdir -p .github/workflows
    cp wordpress-cloud-at-k8s/.github/workflows/TerraformAWS.yml .github/workflows/TerraformAWS.yml
    ```
10. Update the `.github/workflows/TerraformAWS.yml` with your env.

11. Commit `init` and push all the changes to the repository.

12. GitHub Actions will automatically trigger the pipeline to deploy the infrastructure in AWS.

13. Wait for the pipeline to complete successfully to ensure the infrastructure is created successfully.

---

### After successfully completing these steps, revert to the main [Documentation](/README.md) in step Usage.