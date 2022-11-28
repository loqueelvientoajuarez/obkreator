#! /bin/sh

PACKAGE=obkreator
VENV=venv

# clean everything about virtual env. and builds

rm -rf ${VENV}
rm -rf dist/*
rm -rf build/*
rm -rf *egg-info src/*egg-info

# create the new python environement

python3 -m venv ${VENV} 
. ${VENV}/bin/activate

echo "python and pip executables:"
echo `which python`
echo `which pip`

## upgrade key modules in the environement

python -m pip install --upgrade pip
python -m pip install --upgrade build
python -m pip install --upgrade twine

## build the package distribution 
python3 -m build
if [ $? -ne 0 ]; then
    echo ""
    echo "Failure to build package"
    exit $?
fi

# either install locally or upload to pypi
if [ -z "$1" ]; then
    echo "Local install from wheel"
    python -m pip install --upgrade dist/${PACKAGE}-*.whl
    echo ""
    if [ $? -ne 0 ]; then
        echo "Failure to install package from local wheel"
        exit $?
    fi
else
    echo "Upload to repository and install from there"
    python -m twine upload --repository $1 dist/*
    if [ $? -ne 0 ]; then
        echo ""
        echo "Failure to upload package to $1"
        exit $?
    fi
    if [ "$1" = "testpypi" ]; then
        INDEX="--index-url https://test.pypi.org/simple"
    else
        INDEX=""
    fi
    python -m pip install ${INDEX} --upgrade --no-cache-dir ${PACKAGE}
    if [ $? -ne 0 ]; then
        echo ""
        echo "Failure to install package from $1"
        exit $?
    fi
fi

echo ""
echo "Package built and installed sucessfully"        
echo "Don't forget to source ${VENV}/bin/activate to use/test package locally"
