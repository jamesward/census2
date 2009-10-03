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
package
{

import flash.display.Shape;
import flash.geom.Point;

import mx.core.mx_internal;
import mx.controls.Button;
import mx.controls.ButtonPhase;

use namespace mx_internal;

public class ArrowButton extends Button
{
  
  public static const LEFT:String = "left";

  public static const RIGHT:String = "right";

  private var _direction:String;

  public function get direction():String
  {
    return _direction;
  }
  public function set direction(_direction:String):void
  {
    if ((_direction != LEFT) && (_direction != RIGHT))
    {
      throw new Error("Direction must be right or left");
    }
    this._direction = _direction;
    invalidateDisplayList();
  }
  
  override protected function updateDisplayList(w:Number, h:Number):void
  {
    super.updateDisplayList(w, h);

    if (getChildByName("arrow") != null)
    {
        removeChild(getChildByName("arrow"));
    }

    if ((_direction == LEFT) || (_direction == RIGHT))
    {
      var arrow:Shape = new Shape();
      arrow.name = "arrow";

      var fColor:int;
      if (enabled)
      {
        if (phase == ButtonPhase.OVER)
        {
          fColor = getStyle("textRollOverColor");
        }
        else
        {
          fColor = getStyle("color");
        }
      }
      else
      {
        fColor = getStyle("disabledColor");
      }
      var p1:Point;
      var p2:Point;
      var p3:Point;
  
      if (direction == LEFT)
      {
        p1 = new Point(w / 2 - 5, h / 2); // left
        p2 = new Point(w / 2 + 3, h / 2 - 5); // top
        p3 = new Point(w / 2 + 3, h / 2 + 5); // bottom
      }
      else if (direction == RIGHT)
      {
        p1 = new Point(w / 2 + 5, h / 2); // right
        p2 = new Point(w / 2 - 3, h / 2 - 5); // top
        p3 = new Point(w / 2 - 3, h / 2 + 5); // bottom
      }

      arrow.graphics.beginFill(fColor);
      arrow.graphics.moveTo(p1.x, p1.y);
      arrow.graphics.lineTo(p2.x, p2.y);
      arrow.graphics.lineTo(p3.x, p3.y);
      arrow.graphics.lineTo(p1.x, p1.y);
      arrow.graphics.endFill();
      this.addChild(arrow);
    }
  }
}
}
