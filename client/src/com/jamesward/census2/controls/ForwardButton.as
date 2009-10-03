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
import mx.controls.Button;
import flash.geom.Point;

public class ForwardButton extends Button
{
  override protected function updateDisplayList(w:Number, h:Number):void
  {
    super.updateDisplayList(w, h);

    graphics.beginFill(0xcccccc);
    var p1:Point = new Point(w / 2 + 4, h / 2); // right
    var p2:Point = new Point(w / 2 - 4, h / 2 - 5); // top
    var p3:Point = new Point(w / 2 - 4, h / 2 + 5); // bottom
    graphics.moveTo(p1.x, p1.y);
    graphics.lineTo(p2.x, p2.y);
    graphics.lineTo(p3.x, p3.y);
    graphics.lineTo(p1.x, p1.y);
    graphics.endFill();

  }
}
}
