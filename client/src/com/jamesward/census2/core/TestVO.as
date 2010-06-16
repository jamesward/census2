package com.jamesward.census2.core
{

[Bindable]
public class TestVO
{
  public function TestVO(id:String, url:String, name:String, description:String)
  {
    this.id = id;
    this.url = url;
    this.name = name;
    this.description = description;
  }

  public var id:String;

  public var url:String;

  public var name:String;

  public var description:String;
}
}