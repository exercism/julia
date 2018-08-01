#!/usr/bin/env python3
import os
import nbformat as nbf

def generate_notebook(slug, readme, stub, tests):
    nb = nbf.v4.new_notebook()
    nb['cells'] = [
        nbf.v4.new_markdown_cell(readme),
        nbf.v4.new_code_cell('# submit\n' + stub),
        nbf.v4.new_code_cell(tests),
        nbf.v4.new_code_cell(f'''\
# To submit your exercise, you need to save your solution in a file called {slug}.jl before using the CLI.
# You can either create it manually or use the following functions, which will automatically
# save every notebook cell starting with `# submit` in that file.

# Pkg.add("Exercism")
# using Exercism
# Exercism.create_submission("{slug}")
'''),
    ]

    return nb


def notebookify_tests(slug, tests):
    return tests.replace(f'include("{slug}.jl")', f'# include("{slug}.jl")')



if __name__ == '__main__':
    root = os.path.join('.', 'exercises')

    for item in os.listdir(root):
        if os.path.isdir(os.path.join(root, item)):
            slug = item
            with open(os.path.join(root, item, 'README.md'), 'r', encoding='utf-8') as f:
                readme = f.read()
            with open(os.path.join(root, item, f'{slug}.jl'), 'r', encoding='utf-8') as f:
                stub = f.read()
            with open(os.path.join(root, item, 'runtests.jl'), 'r', encoding='utf-8') as f:
                tests = notebookify_tests(slug, f.read())

            nb = generate_notebook(slug, readme, stub, tests)
            nbf.write(nb, os.path.join(root, item, f'{slug}.ipynb'))
