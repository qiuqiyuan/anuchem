/*
 * This file is part of ANUChem.
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 * (C) Copyright Josh Milthorpe 2012-2013.
 */
package au.edu.anu.mm;

import x10.compiler.Inline;

import x10x.vector.Point3d;

public struct OctantId(x:UByte, y:UByte, z:UByte, level:UByte) implements Comparable[OctantId] {
    static LEAF_MASK = 16777215UN; // octant ID without level

    /** 
     * Return the top level of octants actually used in the method.
     * TODO This should be 0 for the periodic FMM and 2 for the non-periodic FMM.
     */
    static TOP_LEVEL = 2UY;

    public def this(x:UByte, y:UByte, z:UByte, level:UByte) {
        property(x,y,z,level);
    }

    public def compareTo(b:OctantId):Int {
        val levelComp = this.level.compareTo(b.level);
        if (levelComp == 0n) {
            val cX = OctantId.log2(this.x ^ b.x);
            val cY = OctantId.log2(this.y ^ b.y);
            val cZ = OctantId.log2(this.z ^ b.z);
            if (cX >= cY) {
                 if (cX >= cZ) {
                    return x.compareTo(b.x);
                 } else {
                    return z.compareTo(b.z);
                 }
            } else {
                if (cY >= cZ) {
                    return y.compareTo(b.y);
                } else {
                    return z.compareTo(b.z);
                }
            }
        }
        return levelComp;
    }

    /**
     * Copied from x10.lang.Math.log2 - but without 'assert powerOf2(p);' 
     * @return ceil[log2(p)]
     */
    private static @Inline def log2(var p:UByte):UByte {
        var i:UByte = 0UY;
        while (p > 1UY) { p = p >> 1; i++; }
        return i;
    }

    public operator this < (x:OctantId) = (this.compareTo(x) < 0);
    public operator this <= (x:OctantId) = (this.compareTo(x) <= 0);
    public operator this > (x:OctantId) = (this.compareTo(x) > 0);
    public operator this >= (x:OctantId) = (this.compareTo(x) >= 0);

    public def next():OctantId {
        return OctantId.getFromMortonId(this.getMortonId()+1UN);
    }

    public def getMortonId():UInt {
        return getMortonId(x as UInt, y as UInt, z as UInt, level as UInt);
    }

    public @Inline static def getMortonId(x:UInt, y:UInt, z:UInt, level:UInt):UInt {
        //Console.OUT.printf("x %8s y %8s z %8s level %8s\n", x.toBinaryString(), y.toBinaryString(), z.toBinaryString(), level.toBinaryString());
        var id:UInt = 0UN;
        var bitmask:UInt = 1UN;
        var shift:Int = 0n;
        for (i in 0..7) {
            id |= (bitmask & z) << shift++;
            id |= (bitmask & y) << shift++;
            id |= (bitmask & x) << shift;
            bitmask = bitmask << 1;
        }
        id |= level << 24;
        //Console.OUT.printf("Morton id = %32s\n", id.toBinaryString());
        return id;
    }

    public static def getFromMortonId(mortonId:UInt):OctantId {
        //Console.OUT.printf("getFromMortonId = %32s\n", mortonId.toBinaryString());
        val level = (mortonId >> 24) as UInt;
        var x:UInt = 0UN;
        var y:UInt = 0UN;
        var z:UInt = 0UN;
        var shift:Int = 16n;
        var bitmask:UInt = 1UN << 23;
        for (i in 0..7) {
            x |= (mortonId & bitmask) >> shift--; bitmask = bitmask >> 1;
            y |= (mortonId & bitmask) >> shift--; bitmask = bitmask >> 1;
            z |= (mortonId & bitmask) >> shift;   bitmask = bitmask >> 1;
        }
        //Console.OUT.printf("x %8s y %8s z %8s level %8s\n", (x as UByte).toBinaryString(), (y as UByte).toBinaryString(), (z as UByte).toBinaryString(), (level as UByte).toBinaryString());
        return OctantId(x as UByte, y as UByte, z as UByte, level as UByte);
    }

    /** 
     * Gets the leaf Morton ID, which does not include the octant's level.
     * Equivalent to mortonId & LEAF_MASK
     */     
    public def getLeafMortonId():UInt {
        val x = this.x as UInt;
        val y = this.y as UInt;
        val z = this.z as UInt;
        //Console.OUT.printf("x %8s y %8s z %8s\n", x.toBinaryString(), y.toBinaryString(), z.toBinaryString());
        var id:UInt = 0UN;
        var bitmask:UInt = 1UN;
        var shift:Int = 0n;
        for (i in 0..7) {
            id |= (bitmask & z) << shift++;
            id |= (bitmask & y) << shift++;
            id |= (bitmask & x) << shift;
            bitmask = bitmask << 1;
        }
        //Console.OUT.printf("leaf Morton id = %32s\n", id.toBinaryString());
        return id;
    }

    public static def getLeafMortonId(atomCentre:Point3d, invSideLength:Double, offset:Double):UInt {
        val x = (atomCentre.i * invSideLength + offset) as UInt;
        val y = (atomCentre.j * invSideLength + offset) as UInt;
        val z = (atomCentre.k * invSideLength + offset) as UInt;
        //Console.OUT.printf("x %8s y %8s z %8s\n", x.toBinaryString(), y.toBinaryString(), z.toBinaryString());
        var id:UInt = 0UN;
        var bitmask:UInt = 1UN;
        var shift:Int = 0n;
        for (i in 0..7) {
            id |= (bitmask & z) << shift++;
            id |= (bitmask & y) << shift++;
            id |= (bitmask & x) << shift;
            bitmask = bitmask << 1;
        }
        //Console.OUT.printf("morton id = %32s\n", id.toBinaryString());
        return id;
    }

    /** @return the octant ID of the parent of this octant */
    public def getParentId():OctantId {
        return new OctantId(x/2UY, y/2UY, z/2UY, level-1UY);
    }

    /** @return the anchor of this octant */
    public def getAnchor(dMax:UByte):OctantId {
        if (level == dMax) return this;
        val shift = (dMax - level);
        return new OctantId(x<<shift, y<<shift, z<<shift, dMax);
    }

    /** @return the index of the given child octant in this (shared) octant's child array */
    public def getChildIndex(dMax:UByte, childId:OctantId):Int {
        return (childId.x%2UY << 2n) | (childId.y%2UY << 1n) | (childId.z%2n);
    }

    public def toString(): String {
        return "" + level + ":(" + x + "," + y + "," + z + ")";
    }
}
