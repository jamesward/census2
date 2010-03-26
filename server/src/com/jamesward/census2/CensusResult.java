package com.jamesward.census2;

import java.util.Date;

public class CensusResult
{

  public CensusResult()
  {
  }
  
  public CensusResult(String ipAddress, String testId, String resultType, Integer resultData, Boolean gzip, Integer numRows)
  {
    setCreateDate(new Date());
    setIpAddress(ipAddress);
    setTestId(testId);
    setResultType(resultType);
    setResultData(resultData);
    setGzip(gzip);
    setNumRows(numRows);
  }

  @Override
  public int hashCode()
  {
    final int prime = 31;
    int result = 1;
    result = prime * result
        + ((createDate == null) ? 0 : createDate.hashCode());
    result = prime * result + ((fpVersion == null) ? 0 : fpVersion.hashCode());
    result = prime * result + ((gzip == null) ? 0 : gzip.hashCode());
    result = prime * result + ((ipAddress == null) ? 0 : ipAddress.hashCode());
    result = prime * result + ((numRows == null) ? 0 : numRows.hashCode());
    result = prime * result + ((os == null) ? 0 : os.hashCode());
    result = prime * result
        + ((resultData == null) ? 0 : resultData.hashCode());
    result = prime * result
        + ((resultType == null) ? 0 : resultType.hashCode());
    result = prime * result + ((testId == null) ? 0 : testId.hashCode());
    return result;
  }

  @Override
  public boolean equals(Object obj)
  {
    if (this == obj)
      return true;
    if (obj == null)
      return false;
    if (getClass() != obj.getClass())
      return false;
    CensusResult other = (CensusResult) obj;
    if (createDate == null)
    {
      if (other.createDate != null)
        return false;
    } else if (!createDate.equals(other.createDate))
      return false;
    if (fpVersion == null)
    {
      if (other.fpVersion != null)
        return false;
    } else if (!fpVersion.equals(other.fpVersion))
      return false;
    if (gzip == null)
    {
      if (other.gzip != null)
        return false;
    } else if (!gzip.equals(other.gzip))
      return false;
    if (ipAddress == null)
    {
      if (other.ipAddress != null)
        return false;
    } else if (!ipAddress.equals(other.ipAddress))
      return false;
    if (numRows == null)
    {
      if (other.numRows != null)
        return false;
    } else if (!numRows.equals(other.numRows))
      return false;
    if (os == null)
    {
      if (other.os != null)
        return false;
    } else if (!os.equals(other.os))
      return false;
    if (resultData == null)
    {
      if (other.resultData != null)
        return false;
    } else if (!resultData.equals(other.resultData))
      return false;
    if (resultType == null)
    {
      if (other.resultType != null)
        return false;
    } else if (!resultType.equals(other.resultType))
      return false;
    if (testId == null)
    {
      if (other.testId != null)
        return false;
    } else if (!testId.equals(other.testId))
      return false;
    return true;
  }

  public Date getCreateDate()
  {
    return createDate;
  }

  public void setCreateDate(Date createDate)
  {
    this.createDate = createDate;
  }

  public String getIpAddress()
  {
    return ipAddress;
  }

  public void setIpAddress(String ipAddress)
  {
    this.ipAddress = ipAddress;
  }

  public String getTestId()
  {
    return testId;
  }

  public void setTestId(String testId)
  {
    this.testId = testId;
  }

  public String getResultType()
  {
    return resultType;
  }

  public void setResultType(String resultType)
  {
    this.resultType = resultType;
  }

  public Integer getResultData()
  {
    return resultData;
  }

  public void setResultData(Integer resultData)
  {
    this.resultData = resultData;
  }

  public String getOs()
  {
    return os;
  }

  public void setOs(String os)
  {
    this.os = os;
  }

  public String getFpVersion()
  {
    return fpVersion;
  }

  public void setFpVersion(String fpVersion)
  {
    this.fpVersion = fpVersion;
  }

  public Boolean getGzip()
  {
    return gzip;
  }

  public void setGzip(Boolean gzip)
  {
    this.gzip = gzip;
  }

  public Integer getNumRows()
  {
    return numRows;
  }

  public void setNumRows(Integer numRows)
  {
    this.numRows = numRows;
  }



  private Date createDate;
  
  private String ipAddress;
  
  private String testId;
  
  private String resultType;
  
  private Integer resultData;

  private String os;
  
  private String fpVersion;
  
  private Boolean gzip;
  
  private Integer numRows;
  
}
