# Process for Installing Git and GitHub Desktop, and Managing a GitHub Repository for Books

### 1. Installing Git and GitHub Desktop

Follow these steps to install Git and GitHub Desktop on your system:

#### Installing Git

1. Download Git from the official website: [https://git-scm.com/downloads](https://git-scm.com/downloads)
2. Run the installer and follow the default setup instructions.
3. Verify the installation by opening a terminal or command prompt and running:
   ```sh
   git --version
   ```

#### Installing GitHub Desktop

1. Download GitHub Desktop from [https://desktop.github.com/](https://desktop.github.com/)
2. Run the installer and follow the setup instructions.
3. Log in to your GitHub account when prompted.

### 2. Creating a GitHub Repository

Follow these steps to create a repository with a structured naming convention:

1. Log in to your GitHub account.
2. Click on the **New Repository** button.
3. Set the **Repository Name** in the following format:
   ```
   ds-book-name-year-city-publisher
   ```

   Example:
   ```
   ds-introduction-to-islam-2005-karachi-darul-ishaat
   ```
4. Select the **Public** option.
5. Check the **Add a README file** checkbox to create a `README.md` file.
6. Click **Create Repository**.

### 3. Editing the `README.md` File

1. Navigate to the newly created repository.
2. Click on the `README.md` file.
3. Click on the **Edit** button (pencil icon).
4. Add a link to the original source of the PDF files in the following format:
   ```
   Original PDF Source: [Link to Source](https://example.com/original-source)
   ```
5. Click **Commit Changes** to save the update.

### 4. Downloading the Repository Using GitHub Desktop

1. Open GitHub Desktop and log in to your GitHub account.
2. Click on **File > Clone Repository**.
3. Select the repository from the list or enter the repository URL.
4. Choose the destination folder on your local machine.
5. Click **Clone** to download the repository.

### 5. Creating Required Folders and Adding `.gitkeep` Files

1. Navigate to the cloned repository folder on your local machine.
2. Create the following folders inside the repository:
   - `pdf`
   - `png`
   - `txt`
   - `json`
3. Inside each folder, create an empty `.gitkeep` file to ensure the folder is included in version control.
   - Or run following command. Open a terminal or command prompt and run:
     ```sh
     touch pdf/.gitkeep png/.gitkeep txt/.gitkeep json/.gitkeep
     ```
5. In `README.md` add following section:
   ```md
   Type: `<Type of dataset i.e. File , Scrape, Manual>`
   URL: `<URL of for example PDF File website, Scrapped website URL>`
   ```
6. Use command below to upload PDFs to Commit and push the changes to GitHub or use **GitHub Desktop** to publish changes (See below):
   ```sh
   git add .
   git commit -m "Added required folders and .gitkeep files"
   git push origin main
   ```

### 6. Committing and Pushing Changes Using GitHub Desktop

1. Open GitHub Desktop and navigate to the cloned repository.
2. Make the necessary changes or add files to the repository.
3. In GitHub Desktop, you will see the changed files listed in the **Changes** tab.
4. Add a commit message describing the changes.
5. Click **Commit to main**.
6. Click **Push origin** to upload the changes to GitHub.

This completes the setup process for installing Git, GitHub Desktop, and managing book repositories on GitHub efficiently.

