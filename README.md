# TemplateRepository_Python
A template for python project across multiple purpose

## Tree structure of project

```Tree
.
├── CHANGELOG.md
├── LICENSE
├── packages
│   └── helloworld
│       ├── hello
│       │   ├── __init__.py
│       │   └── output.py
│       ├── requirements.txt
│       ├── run.py
│       └── world
│           ├── __init__.py
│           └── string.py
├── README.md
├── requirements.txt
├── resources
├── scripts
│   └── development
│       ├── README.md
│       ├── source.sh
│       └── tools
│           └── run.sh
└── VERSION
```

**8 directories, 14 files**

## How to use it

## Clone it

To use this template you need to clone it with a new name and remove the .git directory:

```Bash
git clone https://github.com/Wabri/TemplateRepository_Python.git <your_name>

cd <your_name>

rm -rf .git
```

## Install.sh

Is also possible to use the install.sh scripts and reuse this template multiple times.
The first thing is to clone the project:

```bash
git clone https://github.com/Wabri/TemplateProject_python.git
```

Then move inside the repository:

```Bash
cd TemplateProject_python
```

And run the install.sh with arguments or none:

```Bash
./install.sh --directory path_to_workspace --name project_name --repository https://github.com/github_name/repository_name.git
```

A simple example is:

```Bash
./install.sh --directory ~/workspace/ --name my_awesome_new_project --repository https://github.com/wabri/AwesomePythonProject.git
```

