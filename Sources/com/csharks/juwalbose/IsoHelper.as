package com.csharks.juwalbose
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class IsoHelper
	{
		/**
		 * convert an isometric point to 2D
		 * */
		public static function isoTo2D(pt:Point):Point{
			//gx=(2*isoy+isox)/2;
			//gy=(2*isoy-isox)/2
			var tempPt:Point=new Point(0,0);
			tempPt.x=(2*pt.y+pt.x)/2;
			tempPt.y=(2*pt.y-pt.x)/2;
			return(tempPt);
		}
		/**
		 * convert a 2d point to isometric
		 * */
		public static function twoDToIso(pt:Point):Point{
			//gx=(isox-isoxy;
			//gy=(isoy+isox)/2
			var tempPt:Point=new Point(0,0);
			tempPt.x=pt.x-pt.y;
			tempPt.y=(pt.x+pt.y)/2;
			return(tempPt);
		}
		
		/**
		 * convert a 2d point to specific tile row/column
		 * */
		public static function getTileCoordinates(pt:Point, tileHeight:Number):Point{
			var tempPt:Point=new Point(0,0);
			tempPt.x=Math.floor(pt.x/tileHeight);
			tempPt.y=Math.floor(pt.y/tileHeight);
			
			return(tempPt);
		}
		
		/**
		 * convert specific tile row/column to 2d point
		 * */
		public static function get2dFromTileCoordinates(pt:Point, tileHeight:Number):Point{
			var tempPt:Point=new Point(0,0);
			tempPt.x=pt.x*tileHeight;
			tempPt.y=pt.y*tileHeight;
			
			return(tempPt);
		}
		/**
		 * creates an isometric grid with specified col,row,tile height and tile width
		 * */
		public static function createIsoGrid(cols:uint,rows:uint,tileWidth:Number,tileHeight:Number):Sprite{
			var tempSprite:Sprite=new Sprite();
			var d:Point=new Point(0,tileHeight*rows);
			var c:Point=new Point(tileWidth*cols,tileHeight*rows);
			var b:Point=new Point(tileWidth*cols,0);
			var a:Point=new Point(0,0);
			
			tempSprite.graphics.lineStyle(1,0x000000);
			var srcPt:Point=new Point(0,a.y);
			var destPt:Point=new Point(0,0);
			for(var i:uint=0;i<=cols;i++){
				srcPt.x=a.x+(i*tileWidth);
				srcPt.y=a.y;
				destPt.x=d.x+(i*tileWidth);
				destPt.y=d.y;
				srcPt=IsoHelper.twoDToIso(srcPt);
				destPt=IsoHelper.twoDToIso(destPt);
				tempSprite.graphics.moveTo(srcPt.x,srcPt.y);
				tempSprite.graphics.lineTo(destPt.x,destPt.y);
			}
			for(i=0;i<=rows;i++){
				srcPt.x=d.x;
				srcPt.y=a.y+(i*tileHeight);
				destPt.x=b.x;
				destPt.y=b.y+(i*tileHeight);;
				srcPt=IsoHelper.twoDToIso(srcPt);
				destPt=IsoHelper.twoDToIso(destPt);
				tempSprite.graphics.moveTo(srcPt.x,srcPt.y);
				tempSprite.graphics.lineTo(destPt.x,destPt.y);
			}
			a=IsoHelper.twoDToIso(a);
			b=IsoHelper.twoDToIso(b);
			c=IsoHelper.twoDToIso(c);
			d=IsoHelper.twoDToIso(d);
			tempSprite.graphics.beginFill(0xff0000);
			tempSprite.graphics.drawCircle(a.x,a.y,5);
			tempSprite.graphics.endFill();
			tempSprite.graphics.beginFill(0x00ff00);
			tempSprite.graphics.drawCircle(b.x,b.y,5);
			tempSprite.graphics.endFill();
			tempSprite.graphics.beginFill(0x0000ff);
			tempSprite.graphics.drawCircle(c.x,c.y,5);
			tempSprite.graphics.endFill();
			tempSprite.graphics.beginFill(0x00ffff);
			tempSprite.graphics.drawCircle(d.x,d.y,5);
			tempSprite.graphics.endFill();
			return(tempSprite);
		}
	}
}