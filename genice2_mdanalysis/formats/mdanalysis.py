# coding: utf-8
"""
Make a Universe for MDAnalysis.
"""
desc={"ref": {"MDanalysis": "https://github.com/MDAnalysis/mdanalysis"},
      "brief": "MDAnalysis integration.",
      "usage": ""}


# from collections import defaultdict
from logging import getLogger
import numpy as np
from genice2.decorators import timeit, banner
import genice2.formats
import MDAnalysis as mda
from genice2.cell import cellshape

class Format(genice2.formats.Format):
    """
Make a Universe for MDAnalysis. 

Options:
    # format=x   Output a topology file in x format.
    """


    def __init__(self, **kwargs):
        unknown = dict()
        self.format = None
        jupyter = False
        for k, v in kwargs.items():
            # if k == "format":
            #     self.format = v
            # else:
                unknown[k] = v
        super().__init__(**unknown)
        self.output = None


    def hooks(self):
        return {7:self.Hook7}

    @timeit
    @banner
    def Hook7(self, ice):
        "Process all molecules."

        logger = getLogger()
        logger.info("  Total number of atoms: {0}".format(len(ice.atoms)))
        
        n_atoms  = len(ice.atoms)
        n_waters = ice.reppositions.shape[0]
        atom_resindex = np.array([row[4] for row in ice.atoms])
        universe = mda.Universe.empty(n_atoms=n_atoms,
                                      n_residues=n_waters,
                                      atom_resindex=atom_resindex,
                                      trajectory=True,)
        universe.add_TopologyAttr('name', [row[2] for row in ice.atoms])
        universe.add_TopologyAttr('type', ['O', 'H', 'H']*n_waters)
        universe.add_TopologyAttr('resname', ["SOL"]*n_waters)
        universe.atoms.positions = np.array([row[3] for row in ice.atoms])*10 # AA
        # cellは?
        universe.dimensions = cellshape(ice.repcell.mat*10)
        
        self.output = universe
