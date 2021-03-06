/*
 * This file is part of ANUChem.
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 * (C) Copyright Josh Milthorpe 2010.
 */
package au.edu.anu.mm;

import x10.io.File;
import x10.io.FileReader;
import au.edu.anu.chem.Molecule;
import au.edu.anu.chem.mm.MMAtom;
import x10x.vector.Point3d;

/**
 * This class reads XYZ molecular structure files of the following format:
 *  <number of atoms>
 *  <title>
 *  species x y z // repeated, positions in nm
 */
public class XYZStructureFileReader { 
    var fileName : String;

    public def this(fileName : String) { 
        this.fileName = fileName;
    }

    public def readMolecule(speciesSpecs:Rail[SpeciesSpec]) : Molecule[MMAtom] {
        val file = new FileReader(new File(fileName));
        // line 1: number of atoms
        val numAtoms = Int.parseInt(file.readLine().trim());
        // line 2: structure title
        val title = file.readLine().split(" ");
        var molecule : Molecule[MMAtom] = new Molecule[MMAtom](title(0));
        // lines 3..*: atom positions
        for(var i:Long=0; i<numAtoms; i++) {
            val words = file.readLine().split(" ");
            val symbol = words(0);
            var species:Int = -1n;
            var speciesSpec:SpeciesSpec = null;
            for (j in 0..(speciesSpecs.size-1)) {
                speciesSpec = speciesSpecs(j);
                if (speciesSpec != null && symbol.equals(speciesSpec.name)) {
                    species = j as Int;
                    break;
                }
            }
            if (species == -1n) {
                throw new IllegalArgumentException("no species found for symbol " + symbol);
            }
            Console.OUT.println("found species " + speciesSpec.number + " " + speciesSpec.name + " " + speciesSpec.mass);
            molecule.addAtom(new MMAtom(species,
                                         Point3d(Double.parseDouble(words(1).trim()),
                                                 Double.parseDouble(words(2).trim()),
                                                 Double.parseDouble(words(3).trim())
                                         ),
                                        speciesSpec.mass,
                                        speciesSpec.charge
                        ));
        }
       file.close();
       return molecule;
    }

    public def setFileName(fileName : String) {
        this.fileName = fileName;
    }
}

