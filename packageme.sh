#! /bin/sh

rm dist/*
rm build/*
rm *egg-info/*

python3 setup.py sdist bdist_wheel
python3 -m twine upload -u loqueelvientoajuarez -p "tplpqlp[" dist/*
# python3 -m pip install --upgrade obkreator

