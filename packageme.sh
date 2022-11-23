#! /bin/sh

rm dist/*
rm build/*
rm *egg-info/*

python3 -m pip install --upgrade build
python3 -m build

python3 -m pip install --upgrade twine
python3 -m twine upload -u loqueelvientoajuarez -p "tplpqlp[" dist/*
# python3 -m pip install --upgrade obkreator
