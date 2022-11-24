#! /bin/sh

rm dist/*
rm build/*
rm *egg-info/*

python3 -m pip install --upgrade build
python3 -m build

python3 -m pip install --upgrade twine
python3 -m twine upload dist/*
#python3 -m pip uninstall obkreator
#python3 -m pip install --upgrade --no-cache-dir obkreator
