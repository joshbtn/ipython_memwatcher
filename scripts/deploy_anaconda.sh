#!/bin/bash
# this script uses the ANACONDA_TOKEN env var. 
# to create a token:
# >>> anaconda login
# >>> anaconda auth -c -n travis --max-age 307584000 --url https://anaconda.org/USERNAME/PACKAGENAME --scopes "api:write api:read"
set -e

CONDA_PATH=$(which conda | sed -e 's/\(miniconda.\)\/.*/\1/g')
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Converting conda package..."
conda convert --platform all $CONDA_PATH/conda-bld/linux-64/ipython_memwatcher-*.tar.bz2 --output-dir $SCRIPT_DIR/../conda-bld/

echo "copy original linux-64 packages..."
cp -rv $CONDA_PATH/conda-bld/linux-64/ipython_memwatcher-*.tar.bz2 $SCRIPT_DIR/../conda-bld/

echo "Deploying to Anaconda.org..."
anaconda -t $ANACONDA_TOKEN upload $SCRIPT_DIR/../conda-bld/**/ipython_memwatcher-*.tar.bz2

exit 0