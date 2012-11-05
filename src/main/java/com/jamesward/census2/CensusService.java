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

import java.sql.SQLException;

import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;

import com.jamesward.census2.shared.CensusEntryVO;

@WebService
@SOAPBinding(style = SOAPBinding.Style.RPC)
public class CensusService implements ICensusService
{
    @WebMethod
    public CensusEntryVO[] getElements(int begin, int count)
    {
        CensusDAO dao = new CensusDAO();
        try
        {
            CensusEntryVO[] list = dao.getList(begin, count);
            return list;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            return null;
        }
    }
}