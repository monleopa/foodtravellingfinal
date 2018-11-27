/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author User
 */
public class Category {
    private long cateID;
    private String cateName;

    public Category() {
    }

    public Category(long cateID, String cateName) {
        this.cateID = cateID;
        this.cateName = cateName;
    }

    public long getCateID() {
        return cateID;
    }

    public void setCateID(long cateID) {
        this.cateID = cateID;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }
    
    
}
