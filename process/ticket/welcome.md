# Requirement Ticket Creation Process

## Starting Process
- Go to [issues](https://github.com/orgs/zawjen/projects/8)
- Open a ticket in `Specs` status or column
- In ticket title or tag, if it is marked with [`module`], use `ChatGPT` that module [prompts](../../requirements/supporting/prompts/welcome.md) to create requirements document.
- Possible modules are listed in [hla](../../architecture/design/hla.md). e.g. cli, app, web etc.
- Copy paste and modify [prompts](../../requirements/supporting/prompts/welcome.md) as per ticket requirements and generate `.md` or `markdown` file, just like any file in this repo.
- Discuss requirements with the person who has created the ticket or given the requirement. Consulting with relevant people helps in writing accurate prompts and thereby resulting requirements document.
- Create folder for feature if it is new, or update existing feature `markdown` file available under [requirements](../../requirements/welcome.md) folder.

## Examples
- For example, to create a requirements document for `cli-dataset-uploader` follow process below:
  - Create a folder `cli-dataset-uploader` under `cli` because it a new `cli`
  - Create `welcome.md` and paste `markdown`, copied earlier from ChatGPT 
  - You can press `Copy` icon in the bottom of every ChatGPT chat to copy `markdown` script. See image below
- For example, to create a requirements document for `login` feature for `admin` module follow process below:
  - Create a folder `login` under `web-zawjen-admin` because it a new feature for `admin`
  - Create `welcome.md` and paste `markdown`, copied earlier from ChatGPT 
  - You can press `Copy` icon in the bottom of every ChatGPT chat to copy `markdown` script. See image below
- Study already created [requirements](../../requirements/welcome.md) and [prompts](../../requirements/supporting/prompts/welcome.md) to generate best requirements that developers will love!

## Finishing Touches
- Our requirements contains description, code, unit test and json
- Modify generated requirements if something is missing. Like an image, workflow, video or pdf etc.
- Save new prompt with proper feature heading under [prompts](../../requirements/supporting/prompts/welcome.md) modules.
- Submit PR for review to `Rafey Husain`, Github handle `rafeyseawingai`
- Notify `Rafey Husain` via WhatsApp message or email
- Once PR is approved share ticket in `Zawjen` WhatsApp group

## Share Ticket
- Select message from [standard messages](../../requirements/supporting/messages/welcome.md)
- Enter correct `Ticket`, `Documentation` and `Repo` url
- Share ticket in `Zawjen` WhatsApp group
- Have a blessed day ahead. May you be rewarded for your charity work and sadqah-e-jariyah
---
![Copy](./img/copy.png)