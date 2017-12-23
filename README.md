# pICalculax
Isoelectric point (pI) predictor for chemically modified peptides and proteins.

Published in:<br>
Esben J. Bjerrum , Jan Holst Jensen, and Jakob L. Tolborg<br>
*J Chem Inf Model*. 2017 Aug 28;57(8):1723-1727. doi: [10.1021/acs.jcim.7b00030](http://dx.doi.org/10.1021/acs.jcim.7b00030). <br>
Available at [github.com/EBjerrum/pICalculax](https://github.com/EBjerrum/pICalculax)

A docker image has been compiled by [Troels Schwarz-Linnet](github.com/tlinnet) and is available at [hub.docker.com/r/tlinnet/picalculax](https://hub.docker.com/r/tlinnet/picalculax). Proteax Desktop is NOT installed in the image.

## Notes

For handling condensed molfile formats, [RDKit](http://rdkit.org) needs to be [patched](https://www.wildcardconsulting.dk/useful-information/learn-how-to-hack-rdkit-to-handle-peptides-with-pseudo-atoms). Patch can be found in the [rdkit_patch](https://github.com/tlinnet/pICalculax/tree/docker/rdkit_patch) directory. 

Patching [RDKit](http://rdkit.org) can be diffucult. See the [Dockerfile how this was done](https://github.com/tlinnet/pICalculax/blob/docker/Docker/Dockerfile_local).

For handling conversion of *protein line notation* (PLN) to condensed molformat, [Proteax desktop](http://www.biochemfusion.com/products/proteax_desktop/) is needed. A modification database for Proteax Desktop import is found in the [mods_db](https://github.com/tlinnet/pICalculax/tree/docker/mods_db) directory

Example usage of **pICalculax** can be found in the file [Example_usage.py](https://github.com/EBjerrum/pICalculax/blob/master/Example_Usage.py)


# Online use with mybinder.org

The easiest solution, is to use the service [mybinder.org](https://mybinder.org/), to launch an interactive Jupyter Notebook. [Click here or the icon for access for online environment. ](https://mybinder.org/v2/gh/tlinnet/pICalculax/docker?filepath=Example_Usage.ipynb
)

[![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/tlinnet/pICalculax/docker?filepath=Example_Usage.ipynb)

# How to use Docker

Get prebuild image

```bash
docker pull tlinnet/picalculax:02_picalculax
```

Running docker with image
[Link to run reference:](https://docs.docker.com/v1.11/engine/reference/commandline/run)

### Running on a mac

First make an alias

```bash
alias pi='docker run -ti --rm -p 8888:8888 -v "$PWD":/home/jovyan/work --name picalculax tlinnet/picalculax:02_picalculax'
```

Run it

```bash
# With no arguments, starts Jupyter notebook
pi
# Or else start bash, to start programs
pi bash
```

# Example use

## Command line

Start Docker image, with activated python 2.7 environment

```bash
$ pi pICalculax -h

Python 2.7.14 :: Anaconda custom (64-bit)
Calling pICalculax.py with arguments: -h
usage: pICalculax.py [-h] [--fasta FASTA [FASTA ...]] [--pln PLN [PLN ...]]

Predict isoeletric point pI of peptides and modified peptides

optional arguments:
  -h, --help            show this help message and exit
  --fasta FASTA [FASTA ...]
                        Predict fasta sequence
  --pln PLN [PLN ...]   Predict PLN sequence (Requires Proteax Desktop)
```

With FASTA

```bash
$ pi pICalculax --fasta ICECREAM FATCAT

Python 2.7.14 :: Anaconda custom (64-bit)
Calling pICalculax.py with arguments: --fasta ICECREAM FATCAT
4.14 	ICECREAM
5.02 	FATCAT
```

## Interactive session

Start Docker image, with activated python 2.7 environment

```bash
pi py27
```

```python
from pICalculax import find_pKas, pI
from rdkit import Chem

fasta = 'ICECREAM'
mol = Chem.MolFromFASTA(fasta)

#find pKa values and charge class
pkalist, charge = find_pKas(mol)
#Calculate pI
pIpred = pI(pkalist, charge)

print(pIpred)
```

## Jupyter Notebook example with image
The peptides can be loaded from a SDfile. <br>
*Example usage of the pICalculax for pI prediction of unmodified and modified peptides*

Start image with Jupyter notebook

```bash
pi
```

Then do as follow:

* In your browser, go to [0.0.0.0:8888](http://0.0.0.0:8888)
* Click **New** --> **Python 2**
* Past in from below


```python
from __future__ import print_function
from pICalculax import find_pKas, pI
from rdkit import Chem
from rdkit.Chem import Draw

#Load a protein from SD file in condensed format
sdsup = Chem.SDMolSupplier('pICalculax_dir/Datasets/example_mols.sdf')

def predict_show(mol):
	#Get list of identified pKa values and charge
	pkalist, charge = find_pKas(mol)
	#Predict the pI from the identified pKa values
	piPred = pI(pkalist, charge)
	#Report and Visualize
	print("Predicted pI:%0.2F"%piPred)
	Draw.ShowMol(mol, legend = "Predicted pI:%0.2F"%piPred)
	Draw.tkRoot.update()
	txt = raw_input('Press <ENTER> to continue')

# An unmodified peptide
mol = sdsup[0]
predict_show(mol)

# A peptide with a modification
mol = sdsup[1]
predict_show(mol)
```

## Proteax Desktop example
With Proteax Desktop protein line notation of modified peptides can be converted to a RDKit mol object and the pI predicted

```python
from proteax_desktop import *
prtx = ProteaxDesktop()

pln = 'H-GHANY[Gla]A-OH'

mol = Chem.MolFromMolBlock(prtx.as_molfile(pln,'expansion-mode=condensed'))

#find pKa values and charge class
pkalist, charge = find_pKas(mol)
#Calculate pI
pIpred = pI(pkalist, charge)

print(pIpred)
```

## Proteax Desktop Command line

Protein line notation (Requires Proteax Desktop)

```bash
$ pi pICalculax --pln H-GHANYEA-OH H-GHANY[Gla]A-OH
5.41 	H-GHANYEA-OH
4.77 	H-GHANY[Gla]A-OH
```

