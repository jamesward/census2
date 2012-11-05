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

package com.jamesward.census2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.jamesward.census2.shared.CensusEntryVO;

public class CensusDAO
{

    public CensusEntryVO[] getList(int start, int count) throws SQLException
    {

        Connection c = null;
        ArrayList<CensusEntryVO> list = new ArrayList<CensusEntryVO>();

        String sql = "SELECT id, age, classofworker, education, maritalstatus, race, sex FROM census WHERE id > ? AND id <= ? ORDER BY id ";

        try
        {
            c = ConnectionManager.getConnection();
            PreparedStatement stmt = c.prepareStatement(sql);
            stmt.setInt(1, start);
            stmt.setInt(2, start + count);
            ResultSet rs = stmt.executeQuery();

            while (rs.next())
            {
                CensusEntryVO ce = new CensusEntryVO();
                ce.setId(rs.getInt("id"));
                ce.setAge(rs.getInt("age"));
                ce.setClassOfWorker(rs.getString("classofworker"));
                ce.setEducation(rs.getString("education"));
                ce.setMaritalStatus(rs.getString("maritalstatus"));
                ce.setRace(rs.getString("race"));
                ce.setSex(rs.getString("sex"));
                list.add(ce);
            }
        }
        finally
        {
            try
            {
                c.close();
            }
            catch (Exception ignored)
            {
            }
        }
        return list.toArray(new CensusEntryVO[0]);
    }

}