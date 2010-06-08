/*
Copyright (C) 2007 James Ward
http://www.jamesward.org

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/

package com.jamesward.census2.shared;

import com.google.gwt.user.client.rpc.IsSerializable;

public class CensusEntryVO implements IsSerializable
{

    private int id;
    private int age;
    private String classOfWorker;
    private String education;
    private String maritalStatus;
    private String race;
    private String sex;
    
    public CensusEntryVO()
    {
    	
    }
    
    public CensusEntryVO(int id, int age, String classOfWorker, String education, String maritalStatus, String race, String sex)
    {
    	this.id = id;
    	this.age = age;
    	this.classOfWorker = classOfWorker;
    	this.education = education;
    	this.maritalStatus = maritalStatus;
    	this.race = race;
    	this.sex = sex;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getClassOfWorker() {
        return classOfWorker;
    }

    public void setClassOfWorker(String classOfWorker) {
        this.classOfWorker = classOfWorker;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public String getRace() {
        return race;
    }

    public void setRace(String race) {
        this.race = race;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

}
