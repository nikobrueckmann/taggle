package views 
{
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.events.Event;

	import caurina.transitions.Tweener;

	import flash.display.Sprite;

	import models.Tag;

	import views.TagSprite;

	public class TagList extends Sprite 
	{		
		public var tagSprites : Array;
	
		private  var yPos : Number = 0;

		private var target : uint = 0;
		private var mouseOverBox : Boolean = false;
		
		private var	dragBox : Sprite = new Sprite();
		private var dragRelevanceOld : Number;
		private var dragOldX : Number;
		private var dragOn : Boolean = false;
		private var dragH : Boolean = false;
		private var getMouseX : Boolean = false;
		private var dragNewX : Number;
		private var dragDistance : Number;
		private var newRelevance : Number;
		private var oldHeight : Number;
		private var heightChange : Number;

		private var textOldScaleX : Number;
		private var textOldScaleY : Number;
		
		private var oldText : String;
		private var oldY : Number;
		private var listHeight : Number;
		private var firstTime : Boolean = false;
		private var marginRelevance : Number;

		private var test : TextField = new TextField();
		private var oldRelevance : Number;
		private var lastOldRelevance : Number;
		private var newPosition : uint = 0;
		private var newTag : String;
		private var marginHeight : Number;

		private var tweeningOn : Boolean = false;

		private var cso : TagSprite = null;

		private var mouseTracingY : Boolean = false;
		private var dragV : Boolean = false;

		
		public function TagList() 
		{			
			tagSprites = new Array();
			for(var i : uint = 0 ;i < Application.tagArray.length;i++) 
			{
				var tagSprite : TagSprite = new TagSprite(new Tag(Application.tagArray[i], Application.relevanceArray[i]));
				tagSprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseClick);
				tagSprites.push(tagSprite);
				this.addChild(tagSprite);
			}

			for (i = 0;i < tagSprites.length; i++)
			{
				tagSprites[i].y = yPos;
				yPos += tagSprites[i].height + Vars.tagBoxSpacing;
			}
		}

		public function atIndex(i : uint) : TagSprite 
		{
			return tagSprites[i];
		}

		public function length() : uint 
		{
			return tagSprites.length;
		}

		public function mouseInOut(event : Event) : void 
		{				
			if (getMouseX == true)
			{
				dragOldX = mouseX;
				getMouseX = false;
			}


			if (dragH == false && dragV == false && tweeningOn == false)
			{
				for (var i : int = 0;i < tagSprites.length; i++) 
				{
					if (mouseX >= tagSprites[i].x && mouseX <= tagSprites[i].x + tagSprites[i].width + 40 && mouseY >= tagSprites[i].y && mouseY <= tagSprites[i].y + tagSprites[i].height) 
					{
						target = i;
						Tweener.addTween(tagSprites[i].tagBox, {_color:0xFF009B, alpha: tagSprites[i].tagBox.alpha, time: 0.1, transition: "easeInOutSine" });
						mouseOverBox = true;
					}
				}
				if (mouseOverBox == true && mouseX <= tagSprites[target].x || mouseOverBox == true && mouseX >= tagSprites[target].x + tagSprites[target].width + 40 || mouseOverBox == true && mouseY <= tagSprites[target].y || mouseOverBox == true && mouseY >= tagSprites[target].y + tagSprites[target].height) 
				{
					Tweener.addTween(tagSprites[target].tagBox, {_color:0x000000, alpha: tagSprites[target].tagBox.alpha, time: 0.05, transition: "easeInOutSine" });
					mouseOverBox = false;
				}
			}
					

			for (i = 0;i < tagSprites.length; i++) 
			{
				if (i != target)
				{					
					Tweener.addTween(tagSprites[i].tagBox, {_color:0x000000, alpha: tagSprites[i].tagBox.alpha, time: 0.00});
				}
			}
		}

		// einfŠrben der tagboxen wenn maus in die nŠhe der tagboxen kommt

		public function mouseClick(event : MouseEvent) : void
		{
			cso = TagSprite(event.currentTarget);
			if (cso != null) 
			{
				cso.parent.setChildIndex(cso, cso.parent.numChildren - 1)	;	
				cso = null;
			}
			dragOn = true;
			dragH = true;
			getMouseX = true;
			dragRelevanceOld = Application.relevanceArray[target];
			tagSprites[target].scaleBox.visible = true;
			textOldScaleX = tagSprites[target].tagText.scaleX;
			textOldScaleY = tagSprites[target].tagText.scaleY;
			
			mouseTracingY = true;
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseRelease);
			makeDragBox();
		}

		// klick mit der maus auf eine tagbox

		public function mouseRelease(event : MouseEvent) : void
		{
			if (dragH == true)
			{
				dragH = false;
				mouseTracingY = false;
				tagSprites[target].scaleBox.visible = false;
				stage.removeEventListener(MouseEvent.MOUSE_UP, mouseRelease);
				
				if (Math.abs(dragRelevanceOld - newRelevance) > 0.1)
				{
					scaleH(target, newRelevance);
				}
			}			

			if (dragV == true)
			{
				stopDrag();
				dragV = false;
				mouseTracingY = false;
				tagSprites[target].scaleBox.visible = false;
				stage.removeEventListener(MouseEvent.MOUSE_UP, mouseRelease);
				scaleV(target, newRelevance);
			}
		}	

		// loslassen irgendwo auf der stage

		public function makeDragBox() : void 
		{
			dragBox.graphics.beginFill(0xFF0999);
			// oder soll das drawRect hier raus?
			dragBox.graphics.drawRect(0, 0, tagSprites[target].tagBox.width * Application.relevanceArray[target], tagSprites[target].tagBox.height);
			dragBox.width = tagSprites[target].tagBox.width * Application.relevanceArray[target];
			dragBox.height = tagSprites[target].tagBox.height;
			tagSprites[target].scaleBox.alpha = 1;
		}

		// unsichtbare dragBox damit er bei dragTracing nicht zittert

		
		public function dragTracingH(event : Event) : void 
		{
			if (dragH == true && tweeningOn == false && dragV == false) 
			{
				if (mouseTracingY == true && mouseY > 0 && Math.abs(dragRelevanceOld - newRelevance) < Vars.dragSwitch && mouseY < tagSprites[target].y - 10 || mouseTracingY == true && Math.abs(dragRelevanceOld - newRelevance) < Vars.dragSwitch && mouseY > tagSprites[target].y + tagSprites[target].tagBox.height + 5) 
				{
					mouseTracingY = false;
					dragH = false;
					dragVSwitch();
				}

				dragNewX = mouseX;
				dragDistance = dragNewX - dragOldX;
				newRelevance = (dragBox.width / tagSprites[target].tagBox.width);

				if (newRelevance >= 1) 
				{
					newRelevance = 1;
				}
				if (newRelevance <= 0.25) 
				{
					newRelevance = 0.25;
				}

				if (Math.abs(dragRelevanceOld - newRelevance) > Vars.dragSwitch)
				{
					mouseTracingY = false;
				}

				oldHeight = tagSprites[target].tagText.height;			
				tagSprites[target].tagText.height = newRelevance * 100 - Vars.padding * 2;
				heightChange = tagSprites[target].tagText.height / oldHeight;
				tagSprites[target].tagText.width = tagSprites[target].tagText.width * heightChange;
				tagSprites[target].tagText.x = Vars.padding;
				tagSprites[target].tagText.y = Vars.padding;
				
				tagSprites[target].tagBox.scaleX = newRelevance / Application.relevanceArray[target];
				tagSprites[target].tagBox.scaleY = tagSprites[target].tagBox.scaleX;
				tagSprites[target].tagBox.width = tagSprites[target].tagText.width + 8;
				tagSprites[target].tagBox.height = newRelevance * 100;
				
				tagSprites[target].whiteBox.width = tagSprites[target].tagBox.width;
				tagSprites[target].whiteBox.height = tagSprites[target].tagBox.height;
				tagSprites[target].whiteBox.scaleX = tagSprites[target].tagBox.scaleX;
				tagSprites[target].whiteBox.scaleY = tagSprites[target].tagBox.scaleY;
		
				//maximalbreite
				if (tagSprites[target].tagBox.width * newRelevance > tagSprites[target].tagBox.width * 0.25) 
				{
					dragBox.width = tagSprites[target].tagBox.width * newRelevance ;
					tagSprites[target].scaleBox.width = dragBox.width;
				}
						
				//minimalbreite
				if (dragBox.width < tagSprites[target].tagBox.width * 0.25) 
				{
					dragBox.width = tagSprites[target].tagBox.width * 0.25;
					tagSprites[target].scaleBox.width = dragBox.width;
				}

											
				dragBox.width += dragDistance;
				dragBox.height = tagSprites[target].tagBox.height;
				
				tagSprites[target].scaleBox.height = dragBox.height;
				for (var i : int = target;i < tagSprites.length - 1; i++) 
				{
					tagSprites[i + 1].y = tagSprites[i].y + tagSprites[i].tagBox.height + Vars.tagBoxSpacing;
					tagSprites[i].tagText.y = tagSprites[i].tagBox.y + Vars.padding;
				}
				
				dragOldX = mouseX;
			}
		}

		// verŠnderung der scaleBox bei gedrŸckter maustaste

		public function scaleH(oldPosition : uint, newRelevance : Number) : void 
		{
			tweeningOn = true;
			tagSprites[oldPosition].whiteBox.visible = true;
			
			//besser waere wenn textfeld und abdeckElemente ausserhalb nur einmal erstellen und dann nur skalierung und text ändern.
			oldRelevance = Application.relevanceArray[oldPosition];
			newTag = Application.tagArray[oldPosition];
			test.text = Application.tagArray[oldPosition];
			test.selectable = false;
			test.autoSize = TextFieldAutoSize.LEFT;
			test.antiAliasType = AntiAliasType.ADVANCED;
			test.setTextFormat(Vars.tagTextFormat);
			test.embedFonts = true;
			
			test.autoSize = "left";
			test.x = 100;
			test.y = 100;
			test.scaleX = 1;
			test.scaleY = 1;
			test.scaleX = newRelevance;
			test.scaleY = newRelevance;
			marginHeight = newRelevance * 100 - tagSprites[oldPosition].tagBox.height;

			Tweener.addTween(tagSprites[oldPosition].tagBox, { _color:0xFF009B, alpha: oldRelevance, time:0, transition:"easeOutElastic"});
						
			if (newRelevance < oldRelevance) 
			{				
				newRelevance = Math.floor(newRelevance * 100) / 100;
		
				for (var j : uint = 0;j < tagSprites.length; j++) 
				{
					if (j != oldPosition && Application.relevanceArray[j] >= newRelevance) 
					{
						newPosition = j; 
					}
				}

				if (newRelevance == 0.20) 
				{				
					newPosition = tagSprites.length - 1;					
				}

				if (newPosition != oldPosition)
				{
					for (j = oldPosition + 1;j < newPosition + 1; j++) 
					{
						Tweener.addTween(tagSprites[j], {y:tagSprites[j].y - newRelevance * 100 - 5, time: 0.4, transition: "easeInOutExpo"});
					}						
			
					Tweener.addTween(tagSprites[oldPosition], {y:tagSprites[newPosition].y + tagSprites[newPosition].height - tagSprites[oldPosition].height, time: 0.4, transition: "easeInOutExpo"});
					Tweener.addTween(tagSprites[oldPosition].tagBox, {_color:0x000000, alpha: newRelevance, time: 0.4, transition: "easeInOutExpo", onComplete: function():void 
					{

						tagSprites.sort(byY);

						function byY(a : Object,b : Object) : Number 
						{
							return a.y - b.y;
						}
						tagSprites[oldPosition].whiteBox.visible = false;
						tweeningOn = false;	
					}});
				}	
			}
					
			if (newRelevance > oldRelevance) 
			{
				newRelevance = Math.ceil(newRelevance * 100) / 100;
					
				for (var i : uint = 0;i < tagSprites.length; i++) 
				{
					if (i != oldPosition && Application.relevanceArray[i] >= newRelevance) 
					{
						newPosition = i + 1; 
					}
				}

				if (newRelevance == 1) 
				{				
					newPosition = 0;					
				}

				if (newPosition != oldPosition) 
				{

					if (newPosition != 0) 
					{
						
						
						Tweener.addTween(tagSprites[oldPosition].tagBox, {alpha:newRelevance, _color:0x000000, time: 0.4, transition: "easeInOutExpo"});
						Tweener.addTween(tagSprites[oldPosition], {y:tagSprites[newPosition - 1].y + tagSprites[newPosition - 1].height + 5, time: 0.4, transition: "easeInOutExpo"});
					}
						
					if (newPosition == 0) 
					{
						Tweener.addTween(tagSprites[oldPosition].tagBox, {alpha:newRelevance, time: 0.4, delay:0.1, transition: "easeInOutExpo"});
						Tweener.addTween(tagSprites[oldPosition], {y:0, time: 0.4, transition: "easeInOutExpo", onComplete: function():void 
						{
						}});
					}
					for (i = newPosition;i < oldPosition; i++) 
					{
						Tweener.addTween(tagSprites[i], {y:tagSprites[i].y + newRelevance * 100 + 5, time: 0.4, delay:0.01, transition: "easeInOutExpo", onComplete: function():void 
						{
							tagSprites.sort(byY);

							function byY(a : Object,b : Object) : Number 
							{
								return a.y - b.y;
							}
							tagSprites[oldPosition].whiteBox.visible = false;
							tweeningOn = false;
						}
					});
					}
				}
			}

			if (newPosition == oldPosition) 
			{
				tagSprites[oldPosition].whiteBox.visible = false;
				tweeningOn = false;
				Application.relevanceArray.splice(oldPosition, 1, newRelevance);
			}
			
			
			if (newPosition != oldPosition) 
			{
				Application.tagArray.splice(oldPosition, 1);
				Application.tagArray.splice(newPosition, 0, newTag);
				Application.relevanceArray.splice(oldPosition, 1);
				Application.relevanceArray.splice(newPosition, 0, newRelevance);
			}
		}	

		// tweening nach dem loslassen der maus bei dragH

		public function dragVSwitch() : void 
		{	
			trace(Application.relevanceArray);
			trace(tagSprites[target].tagBox.height);
			
			tagSprites[target].tagBox.height = Application.relevanceArray[target] * 100;
			tagSprites[target].scaleBox.height = Application.relevanceArray[target] * 100;
			
			oldHeight = tagSprites[target].tagText.height;			
			tagSprites[target].tagText.height = tagSprites[target].tagBox.height - Vars.padding * 2;
			heightChange = tagSprites[target].tagText.height / oldHeight;
			tagSprites[target].tagText.width = tagSprites[target].tagText.width * heightChange;
			tagSprites[target].tagText.x = Vars.padding;
			tagSprites[target].tagText.y = Vars.padding;
			
			tagSprites[target].tagBox.width = tagSprites[target].tagText.width + Vars.padding * 2;
			tagSprites[target].scaleBox.width = tagSprites[target].tagBox.width * Application.relevanceArray[target];
			//newRelevance = Application.relevanceArray[target];

			dragH = false;
			dragV = true;	
			tagSprites[target].whiteBox.visible = true;
			tagSprites[target].startDrag();
			listHeight = this.height;
			
			//Tweener.addTween(tagSprites[target], {y : mouseY - tagSprites[target].tagBox.height / 2, time: 0.0, transition: "easeInOutExpo"});
			
			
			trace(tagSprites[target].tagBox.height);
		}

		// ablšsen des tagSprites bei dragV

		public function dragTracingV(event : Event) : void 
		{	
			if ( dragV == true) 
			{				
				if (firstTime == false && target != 0 && tagSprites[target].y < tagSprites[target - 1].y) 
				{
					trace("groesser");
					trace(Application.tagArray);
					trace(Application.relevanceArray);

					oldText = Application.tagArray[target - 1];
					oldRelevance = Application.relevanceArray[target];
					lastOldRelevance = Application.relevanceArray[target - 1];
					newRelevance = Application.relevanceArray[target - 1];

					Application.tagArray.splice(target - 1, 1);
					Application.tagArray.splice(target, 0, oldText);
					Application.relevanceArray.splice(target - 1, 1);
					Application.relevanceArray.splice(target, 0, lastOldRelevance);
					
					trace(Application.tagArray);
					trace(Application.relevanceArray);
					
					tagSprites.sort(byY2);

					function byY2(a : Object,b : Object) : Number 
					{
						return a.y - b.y;
					}

					yPos = 0;
					for (var  i : uint = 0;i < tagSprites.length; i++)
					{
						tagSprites[i].y = yPos;
						yPos += tagSprites[i].height + Vars.tagBoxSpacing;
					}
					target -= 1;
					firstTime = true;			
				}
				
				// eigentlich muss die abfrage so sein aber dann funktiuoniert das sortByY nicht
				//if (firstTime == false && tagSprites[target].y + tagSprites[target].tagBox.height > tagSprites[target + 1].y) 

				if (target != tagSprites.length - 1 && firstTime == false && tagSprites[target].y + tagSprites[target].tagBox.height > tagSprites[target + 1].y + Vars.tagBoxSpacing) 
				{
					trace("kleiner");
					
					trace(Application.tagArray);
					trace(Application.relevanceArray);
					
					oldY = tagSprites[target].y;
					oldText = Application.tagArray[target];
					oldRelevance = Application.relevanceArray[target];
					newRelevance = Application.relevanceArray[target + 1];
				
					Application.tagArray.splice(target, 1);
					Application.tagArray.splice(target + 1, 0, oldText);
					Application.relevanceArray.splice(target, 1);
					Application.relevanceArray.splice(target + 1, 0, oldRelevance);
					
					trace(Application.tagArray);
					trace(Application.relevanceArray);
					
					// geht das vielleicht irgendwie beser ohne oldY?
					tagSprites[target].y = tagSprites[target + 1].y + 1; 
					
					tagSprites.sort(byY);
					
					
					function byY(a : Object,b : Object) : Number 
					{
						return a.y - b.y;
					}

					yPos = 0;
					for ( var j : uint = 0;j < tagSprites.length; j++)
					{
						tagSprites[j].y = yPos;
						yPos += tagSprites[j].height + Vars.tagBoxSpacing;
					}
					

					if (target != tagSprites.length - 1)
					{
						target += 1;
						tagSprites[target].y = oldY;
					}
					firstTime = true;
				}
				
				tagSprites[target].x = 0;
				if (tagSprites[target].y < 0)
				{
					tagSprites[target].y = 0;
				}
				
				if (tagSprites[target].y > listHeight - tagSprites[target].tagBox.height )
				{
					tagSprites[tagSprites.length - 1].y = listHeight - tagSprites[target].tagBox.height ;
				}

				
				firstTime = false;
			}
			
			// bug mit dem abloesen von der x-achse muss eleganter gefixt werden.
			for (i = 0;i < tagSprites.length; i++) 
			{
				tagSprites[i].x = 0; 
			}
		}

		// verŠnderung der sortierung bei dragV

		public function scaleV(newPosition : uint, newRelevance : Number) : void 
		{
			
			trace(Application.tagArray);
			trace(Application.relevanceArray);
			tweeningOn = true;
			marginRelevance = oldRelevance - newRelevance;
			marginRelevance = Math.round(marginRelevance * 100) / 100;
			
			Application.relevanceArray.splice(target, 1, newRelevance);
				
			oldHeight = tagSprites[target].tagText.height;			
			//tagSprites[target].tagText.height = newRelevance * 100 - vars.padding * 2;
			heightChange = (newRelevance * 100 - Vars.padding * 2) / oldHeight;
			//tagSprites[target].tagText.width = tagSprites[target].tagText.width * heightChange;
			//tagSprites[target].tagText.x = vars.padding;
			//tagSprites[target].tagText.y = vars.padding;	

			if (newPosition == 0)
			{
				Tweener.addTween(tagSprites[target], {y: 0, time: 0.4, transition: "easeInOutExpo"});
			}
			if (newPosition != 0)
			{
				Tweener.addTween(tagSprites[target], {y: tagSprites[target - 1].y + tagSprites[target - 1].tagBox.height + Vars.tagBoxSpacing, time: 0.4, transition: "easeInOutExpo"});
			}
			Tweener.addTween(tagSprites[target].tagBox, {_color:0x000000, alpha : newRelevance, height: Application.relevanceArray[target] * 100, width: tagSprites[target].tagText.width * heightChange + 8, alpha: newRelevance, time: 0.4, transition: "easeInOutExpo"});
			Tweener.addTween(tagSprites[target].tagText, {height: newRelevance * 100 - Vars.padding * 2, width: tagSprites[target].tagText.width * heightChange, time: 0.4, transition: "easeInOutExpo", onComplete: function():void 
			{
				tweeningOn = false;	
				trace(Application.tagArray);
				trace(Application.relevanceArray);
				trace(tagSprites[tagSprites.length - 1].tagBox.height);
			}});
			
			Tweener.addTween(tagSprites[target].whiteBox, {height: Application.relevanceArray[target] * 100, width: tagSprites[target].tagText.width * heightChange + 8, time: 0.4, transition: "easeInOutExpo"});
		
			for (var i : uint = newPosition + 1;i < tagSprites.length; i++) 
			{
				Tweener.addTween(tagSprites[i], {y:tagSprites[i].y - marginRelevance * 100, time: 0.4, transition: "easeInOutExpo"});
						
					//	Tweener.addTween(tagSprites[i], {y:tagSprites[i].y - marginRelevance * 100 - 5, time: 0.4, transition: "easeInOutExpo"});
			}	
		}
		// tweening nach dem loslassen der maus bei dragH
	}
}

				


