/*
 * This file is part of ANUChem.
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 * (C) Copyright Australian National University 2010-2013.
 */
package x10x.xla;

import x10.array.Array_2;

import x10x.vector.Vector;
import x10x.matrix.Matrix;

/**
 * The Gaussian elemination solver for A x = B
 *
 * Node: Mostly lifted from MeTA Studio code
 * 
 * @author  V.Ganesh
 */
public class GaussianElimination extends LinearEquationSolver {
    private var row:Rail[Long];
    private var a:Array_2[Double];
    private var x:Rail[Double];

    private var matrixA:Matrix;
    
    private var n:Long, n1:Long;

    public def findSolution(matA:Matrix, vectorB:Vector) : Vector {
        val N = matA.getRowCount();
        this.matrixA = new Matrix(N, N+1);
        a = this.matrixA.getMatrix(); 
        x = vectorB.getVector();

        var i:Long, j:Long;

        //Console.OUT.println("matA: " + matA);
        //Console.OUT.println("vecB: " + vectorB);

        val ta = matA.getMatrix();
        for(i=0; i<N; i++)
            for(j=0; j<N; j++)
                a(i,j) = ta(i,j);

        for(i=0; i<N; i++)
            a(i,N) = x(i);        

        //Console.OUT.println("matA1: " + matrixA);
        
        n  = this.matrixA.getRowCount()-1;
        n1 = this.matrixA.getColCount()-1;

        row = new Rail[Long](this.matrixA.getRowCount(), 0L);
        
        // initilize row vector
        for(j=1; j<=n; j++) 
            row(j) = j;

        // first make the the matrix upper triangular
        upperTriangularize(true);

        // now use back substitution to get the solution
        // first solution from back :)
        x(n) = a(row(n),n1) / a(row(n),n);

        var sum:Double = 0.0;
        for(var k:Long=(n-1); k>=0; k--) {
            sum = 0.0;
            for(var c:Long=(k+1); c<=n; c++) {
                sum += (a(row(k),c) * x(c)); // compute next solutions
            } // end of inner loop

            // the actual next solution
            x(k) = (a(row(k),n1) - sum) / a(row(k),k);
        } // end outer for

        Console.OUT.println("sol: " + vectorB);

        return vectorB;
    }

    /** Upper triangularize the matrix */
    private def upperTriangularize(doOneScale:Boolean) : void {
        // check if matrix is already upper triangular
        // this check may be removed in future
        if (matrixA.isUpperTriangular()) {
            return;
        } // end if

        for (var p:Long=0; p<=n1; p++) {
            simplePivot(p); // apply simple pivoting
            oneScale(p, doOneScale);    // apply simple 1-scaling
        } // end for

        if (matrixA.isSingular(n, row)) {
            Console.OUT.println("Singular matrix!");
            throw new Exception("Singular Matrix");
        } // end if
    }

    /**
     * simplePivot() - This method does simple pivoting if the a[j][j]th element
     *                 is zero. It first finds the a[i][j]th element which is
     *                 numerically greater than a[j][j] and i>j and then
     *                 interchanges the ith and jth rows.
     * @param p - The pth iteration in Gaussian elemination.
     */
    public def simplePivot(p:Long) : void {
        if (p >= n) {
            return;
        } // end if

        // if concerned row's first element is unity
        // or more do not pivot
        if (Math.abs(a(row(p),p)) >= 1) return;

        for(k in (p+1)..n) {
            // check for keeping things near unity
            if ((Math.abs(a(row(k),p))-1) < (Math.abs(a(row(p),p))-1)) {
                // switch the indices to represent a
                // row interchange so as to avoid the overhead
                // of actually moving the row elements  :)
                val temp = row(p);
                row(p) = row(k);
                row(k) = temp;
            } // end if
        } // end for

        if (matrixA.isSingular(p, row)) {
            throw new Exception("Singular Matrix");
        } // end if
    } // end of method simplePivot()

    /**
     * oneScale() - This method makes the a[j][j]th entry at the jth iteration
     *              close to unity by deviding each element of the jth row
     *              by a[j][j].
     * @param p - The jth iteration in Gaussian elemination.
     *        boolean scale - Scale to one or not
     */
    private def oneScale(p:Long, scale:Boolean) {
        var m:Double = 0.0;

        if (p >= n) {
            return;
        } // end if
 
        for(var k:Long=(p+1); k<=n; k++) {
            // compute the multiplicity factor
            m = a(row(k),p) / a(row(p),p);

            for(var c:Long=(p+1); c<=n1; c++) {
                a(row(k),c) -= (m * a(row(p),c));
            } // end inner for

            a(row(k),p) = m;
        } // end outer for

        if (scale) {
            a(row(p),p) = 1.0; // diagonal element is now 1
        } // end if
        
        for(var c:Long=(p+1); c<=n; c++) {
            a(row(c),p) = 0.0; // all entries below diagonal are 0
        } // end for
    } // end of method oneScale()
}


