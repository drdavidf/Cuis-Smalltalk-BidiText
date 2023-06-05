'From Cuis 6.0 [latest update: #5753] on 5 June 2023 at 3:28:03 pm'!
'Description BidiText provides support for displaying and editing bidirectional text.'!
!provides: 'BidiText' 1 109!
SystemOrganization addCategory: 'BidiText'!


!classDefinition: #BidiScrollableTextMorph category: 'BidiText'!
PluggableScrollPane subclass: #BidiScrollableTextMorph
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiScrollableTextMorph class' category: 'BidiText'!
BidiScrollableTextMorph class
	instanceVariableNames: ''!

!classDefinition: #BidiTextMorph category: 'BidiText'!
BoxedMorph subclass: #BidiTextMorph
	instanceVariableNames: 'text editor page yoffset leftMargin rightMargin'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiTextMorph class' category: 'BidiText'!
BidiTextMorph class
	instanceVariableNames: ''!

!classDefinition: #ArabicComposer category: 'BidiText'!
Object subclass: #ArabicComposer
	instanceVariableNames: ''
	classVariableNames: 'Beginning End Isolated Middle'
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'ArabicComposer class' category: 'BidiText'!
ArabicComposer class
	instanceVariableNames: ''!

!classDefinition: #BidiEditor category: 'BidiText'!
Object subclass: #BidiEditor
	instanceVariableNames: 'text point mark history'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiEditor class' category: 'BidiText'!
BidiEditor class
	instanceVariableNames: ''!

!classDefinition: #BidiFork category: 'BidiText'!
Object subclass: #BidiFork
	instanceVariableNames: 'left right parent weight count height'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiFork class' category: 'BidiText'!
BidiFork class
	instanceVariableNames: ''!

!classDefinition: #BidiLine category: 'BidiText'!
Object subclass: #BidiLine
	instanceVariableNames: 'metrics zones newlineTerminated'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiLine class' category: 'BidiText'!
BidiLine class
	instanceVariableNames: ''!

!classDefinition: #BidiLineBreak category: 'BidiText'!
Object subclass: #BidiLineBreak
	instanceVariableNames: 'from to newlineTerminated'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiLineBreak class' category: 'BidiText'!
BidiLineBreak class
	instanceVariableNames: ''!

!classDefinition: #BidiJustifiedLineBreak category: 'BidiText'!
BidiLineBreak subclass: #BidiJustifiedLineBreak
	instanceVariableNames: 'stretch shrink ratio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiJustifiedLineBreak class' category: 'BidiText'!
BidiJustifiedLineBreak class
	instanceVariableNames: ''!

!classDefinition: #BidiLineBreaker category: 'BidiText'!
Object subclass: #BidiLineBreaker
	instanceVariableNames: 'width'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiLineBreaker class' category: 'BidiText'!
BidiLineBreaker class
	instanceVariableNames: ''!

!classDefinition: #BidiJustifiedLineBreaker category: 'BidiText'!
BidiLineBreaker subclass: #BidiJustifiedLineBreaker
	instanceVariableNames: 'stretch shrink'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiJustifiedLineBreaker class' category: 'BidiText'!
BidiJustifiedLineBreaker class
	instanceVariableNames: ''!

!classDefinition: #BidiRaggedLineBreaker category: 'BidiText'!
BidiLineBreaker subclass: #BidiRaggedLineBreaker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiRaggedLineBreaker class' category: 'BidiText'!
BidiRaggedLineBreaker class
	instanceVariableNames: ''!

!classDefinition: #BidiPage category: 'BidiText'!
Object subclass: #BidiPage
	instanceVariableNames: 'paragraphs width'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiPage class' category: 'BidiText'!
BidiPage class
	instanceVariableNames: ''!

!classDefinition: #BidiParagraph category: 'BidiText'!
Object subclass: #BidiParagraph
	instanceVariableNames: 'direction lines width height parent alignment'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiParagraph class' category: 'BidiText'!
BidiParagraph class
	instanceVariableNames: ''!

!classDefinition: #BidiParenComposer category: 'BidiText'!
Object subclass: #BidiParenComposer
	instanceVariableNames: ''
	classVariableNames: 'Paren'
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiParenComposer class' category: 'BidiText'!
BidiParenComposer class
	instanceVariableNames: ''!

!classDefinition: #BidiTextMetrics category: 'BidiText'!
Object subclass: #BidiTextMetrics
	instanceVariableNames: 'width height ascent descent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiTextMetrics class' category: 'BidiText'!
BidiTextMetrics class
	instanceVariableNames: ''!

!classDefinition: #BidiToken category: 'BidiText'!
Object subclass: #BidiToken
	instanceVariableNames: 'tag metrics begin end direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiToken class' category: 'BidiText'!
BidiToken class
	instanceVariableNames: ''!

!classDefinition: #BidiZone category: 'BidiText'!
Object subclass: #BidiZone
	instanceVariableNames: 'beginIndex endIndex metrics'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiZone class' category: 'BidiText'!
BidiZone class
	instanceVariableNames: ''!

!classDefinition: #BidiContraZone category: 'BidiText'!
BidiZone subclass: #BidiContraZone
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiContraZone class' category: 'BidiText'!
BidiContraZone class
	instanceVariableNames: ''!

!classDefinition: #BidiNativeZone category: 'BidiText'!
BidiZone subclass: #BidiNativeZone
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiNativeZone class' category: 'BidiText'!
BidiNativeZone class
	instanceVariableNames: ''!

!classDefinition: #BidiSkipZone category: 'BidiText'!
BidiZone subclass: #BidiSkipZone
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiSkipZone class' category: 'BidiText'!
BidiSkipZone class
	instanceVariableNames: ''!

!classDefinition: #Edge category: 'BidiText'!
Object subclass: #Edge
	instanceVariableNames: 'from to weight'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'Edge class' category: 'BidiText'!
Edge class
	instanceVariableNames: ''!

!classDefinition: #Graph category: 'BidiText'!
Object subclass: #Graph
	instanceVariableNames: 'vertices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'Graph class' category: 'BidiText'!
Graph class
	instanceVariableNames: ''!

!classDefinition: #Vertex category: 'BidiText'!
Object subclass: #Vertex
	instanceVariableNames: 'adj key distance prev'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'Vertex class' category: 'BidiText'!
Vertex class
	instanceVariableNames: ''!


!BidiLine commentStamp: '<historical>' prior: 0!
I represent a continous area of text that occupies a rectangle, representing a single line in a paragraph. 
My indices are relative to the beginning of my paragraph.!

!BidiPage commentStamp: '<historical>' prior: 0!
I represent a continous area of text composed of a sequence of paragraphs.!

!BidiParagraph commentStamp: '<historical>' prior: 0!
I represent a continous area of text that has the same primary writing direction.!

!BidiZone commentStamp: '<historical>' prior: 0!
I represent a continous area of a text line that has the same writing direction. My indices are offsets from the 
beginning of my line's paragraph.!

!BidiContraZone commentStamp: '<historical>' prior: 0!
I am a zone whose writing direction goes against my line's paragraph writing direction!

!BidiNativeZone commentStamp: '<historical>' prior: 0!
I am a zone whose writing direction is the same as my line's paragraph writing direction!

!BidiScrollableTextMorph methodsFor: 'as yet unclassified' stamp: 'DF 6/4/2023 12:05:17'!
build

	| aBidiTextMorph |
	
	aBidiTextMorph := BidiTextMorph new morphExtent: self viewableExtent ; text: model; yourself.
	
	aBidiTextMorph morphHeight: (aBidiTextMorph textHeight max: aBidiTextMorph morphHeight).
	
	self scroller: aBidiTextMorph.
	
	aBidiTextMorph when: #keystroke send: #showCursor: to: self.
	
	! !

!BidiScrollableTextMorph methodsFor: 'as yet unclassified' stamp: 'DF 6/4/2023 09:52:38'!
extentChanged: oldExtent

	self build! !

!BidiScrollableTextMorph methodsFor: 'as yet unclassified' stamp: 'DF 6/4/2023 12:37:19'!
showCursor: oldpos

	"ensure that cursor rect is inside the viewable area "

	| rect delta |
	
	rect := scroller cursorRectangle.

	delta := 0 @ (oldpos origin y - rect origin y).
		
	rect corner y > scroller morphHeight "The scroller's extent is too short"
		ifTrue:[scroller morphExtent: scroller morphExtent - delta].
	
	rect corner y > (self morphHeight - scroller topLeftInOwner y) or:[ rect origin y < (0 - scroller topLeftInOwner y) ] :: 
		ifTrue:[self scrollBy: delta].

! !

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 4/8/2023 16:26:30'!
copySelection

	| aText |

	editor mark = editor point ifTrue:[^self].
	
	aText := editor selection.
	
	Clipboard storeObject: aText.! !

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 5/7/2023 20:54:32'!
cut

	| aText |

	editor mark = editor point ifTrue:[^self].
	
	aText := editor selection.
	Clipboard storeObject: aText.
	
	self performEditingAction: [	editor backspace].
! !

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 5/7/2023 20:55:54'!
paste

	"Paste the text from the shared buffer over the current selection and 
	redisplay if necessary."

	self performEditingAction: [editor paste: Clipboard retrieveStringOrText].
! !

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 4/8/2023 16:31:08'!
pasteRecent
	"Paste an item chose from RecentClippings."

	| clipping |
	(clipping := Clipboard chooseRecentClipping) ifNil: [^ self].
	self clipboardTextPut: clipping.
	^ self paste! !

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 5/7/2023 20:56:43'!
pasteString

	self performEditingAction: [editor paste: Clipboard retrieveStringOrText asPlainString].
! !

!BidiTextMorph methodsFor: 'menus' stamp: 'DF 4/8/2023 15:58:05'!
addCutAndPasteMenuSectionTo: aMenu
	
	"Adds  typical cut and paste operations section to a menu"
	
	aMenu
		add: 'Copy (c)'
		action: #copySelection
		icon: #copyIcon.
	
	aMenu
		add: 'Cut (x)'
		action: #cut
		icon: #cutIcon.

	aMenu
		add: 'Paste (v)'
		action: #paste
		icon: #pasteIcon.
		
	aMenu
		add: 'Paste without Format'
		action: #pasteString
		icon: #pasteIcon.
	
	aMenu
		add: 'Paste...'
		action: #pasteRecent
		icon: #worldIcon.
	
	^aMenu! !

!BidiTextMorph methodsFor: 'menus' stamp: 'DF 4/27/2023 19:13:19'!
addStyleMenuSectionTo: aMenu

	aMenu
		add: 'Set Alignment...'
		action: #chooseAlignment
		icon:	#formatJustifyLeftIcon.
! !

!BidiTextMorph methodsFor: 'menus' stamp: 'DF 4/11/2023 15:04:04'!
addUndoMenuSectionTo: aMenu

	"Adds undo operations to the given menu"

	aMenu
		add: 'Undo - multiple (z)'
		action: #undo
		icon:	#undoIcon.
		
	aMenu
		add: 'Redo - multiple (Z)'
		action: #redo
		icon: #redoIcon.
		
	aMenu
		add: 'Undo / Redo history'
		action: #offerUndoHistory
		icon: #changesIcon.
		
	^aMenu.! !

!BidiTextMorph methodsFor: 'menus' stamp: 'DF 5/27/2023 21:21:58'!
chooseAlignment
	"This is a user command, and _should_ generate undo"

	| aList reply |
	aList := #(left center right justified).
	reply := (SelectionMenu labelList: aList selections: aList) startUpMenu.
	reply ifNil: [ ^self ].
	
	editor align: reply.
	page build: text.
	self redrawNeeded.
	
	^ true! !

!BidiTextMorph methodsFor: 'menus' stamp: 'DF 4/27/2023 19:13:39'!
getMenu
	| aMenu | 
	
	aMenu := MenuMorph new defaultTarget: self.
	aMenu
		addTitle: self class name;
		addStayUpIcons.
		
	aMenu
		add: 'Help...'
		action: #openHelp
		icon: #helpIcon.
	aMenu addLine.
	
	self addUndoMenuSectionTo: aMenu.
	aMenu addLine.

	self addCutAndPasteMenuSectionTo: aMenu.
	aMenu addLine.

	self addStyleMenuSectionTo: aMenu.
	
	^aMenu

! !

!BidiTextMorph methodsFor: 'moving the cursor' stamp: 'DF 6/4/2023 12:07:18'!
moveDown: aKeyboardEvent direction: dir

	| p |

	p := page below: text at: editor point.
	p ifNotNil: [ 
		editor movePointTo: p.
		aKeyboardEvent shiftPressed 
			ifFalse:[	editor moveMarkTo: editor point]. 
		self redrawNeeded ].
	 ^self.
! !

!BidiTextMorph methodsFor: 'moving the cursor' stamp: 'DF 4/27/2023 21:52:34'!
moveLeft: aKeyboardEvent direction: dir

		editor movePointTo: editor point - dir. 
		aKeyboardEvent shiftPressed 
			ifFalse:[	editor moveMarkTo: editor point]. 
		self redrawNeeded. ^self
! !

!BidiTextMorph methodsFor: 'moving the cursor' stamp: 'DF 4/27/2023 21:53:04'!
moveRight: aKeyboardEvent direction: dir

	editor movePointTo: editor point + dir. 
	aKeyboardEvent shiftPressed
		 ifFalse:[	editor moveMarkTo: editor point]. 
	self redrawNeeded. ^self! !

!BidiTextMorph methodsFor: 'moving the cursor' stamp: 'DF 6/4/2023 12:11:45'!
moveUp: aKeyboardEvent direction: dir

	| p |
	
	p := page above: text at: editor point.
	p ifNotNil: [ 
		editor movePointTo: p.
		aKeyboardEvent shiftPressed 
			ifFalse:[	editor moveMarkTo: editor point]. 
		self redrawNeeded ].
	^self.
! !

!BidiTextMorph methodsFor: 'editing' stamp: 'DF 5/20/2023 16:51:53'!
backspace

	| b e delta |

	b := editor point min: editor mark.
	e := editor point max: editor mark.
	
	b = e ifTrue:[b := b - 1 max: 1].
	
	delta := editor backspace.

	page build: text from: b to: e delta: delta.
	
	self redrawNeeded.	
! !

!BidiTextMorph methodsFor: 'editing' stamp: 'DF 5/20/2023 16:51:49'!
performEditingAction: aBlock

	| b e delta |

	b := editor point min: editor mark.
	e := editor point max: editor mark.
	
	delta := aBlock value.

	page build: text from: b to: e delta: delta.
	
	self redrawNeeded.	
! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 6/4/2023 11:49:25'!
doKeyStroke: aKeyboardEvent

	| dir char |
	
	dir := page writingDirectionAt: editor point.
	
	aKeyboardEvent isArrowLeft 
		ifTrue:[^self moveLeft: aKeyboardEvent direction: dir].
	
	aKeyboardEvent isArrowRight 
		ifTrue:[^self moveRight: aKeyboardEvent direction:dir].

	aKeyboardEvent isArrowUp 
		ifTrue:[^self moveUp: aKeyboardEvent direction: dir ].

	aKeyboardEvent isArrowDown 
		ifTrue:[^self moveDown: aKeyboardEvent direction:dir].
	
	aKeyboardEvent isBackspace ifTrue:[ 
		^self backspace] .

	aKeyboardEvent isDelete ifTrue:[ 
		^self performEditingAction: [editor delete] ].

	aKeyboardEvent isReturnKey ifTrue:[ 
		^self performEditingAction: [editor insert: Character lfCharacter] ].
	
	char := aKeyboardEvent keyCharacter.
	
	aKeyboardEvent controlKeyPressed and:[char = $c] :: ifTrue:[
		self copySelection.
		self redrawNeeded. ^self ].

	aKeyboardEvent controlKeyPressed and:[char = $v] :: ifTrue:[^self paste].

	aKeyboardEvent controlKeyPressed and:[char = $x] :: ifTrue:[	^	self cut].

	aKeyboardEvent controlKeyPressed and:[char = $z] :: ifTrue:[^self undo].

	aKeyboardEvent controlKeyPressed and:[char = $Z] :: ifTrue:[^self redo].

	self performEditingAction: [editor insert: char].
	
	
	! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/11/2023 12:36:05'!
doubleClick: aMouseButtonEvent localPosition: localEventPosition
	
	"first move the mark back until a separator or beginning of text"
	
	[ editor mark = (text size + 1) or: [editor mark > 1 and: [ text at:editor mark :: isSeparator not ] ] ]
		whileTrue:[editor moveMarkTo: editor mark - 1 ].
		
	"self assert: editor mark <= text size and: [ editor mark = 1 or: [ text at:editor mark :: isSeparator ] ] "
	
	editor mark > 1 ifTrue:[editor moveMarkTo: editor mark + 1].
		
	"then move the point forward until a separator or end of text"
	
	[ editor point = 1 or: [ editor point < (text size + 1) and:[ text at:editor point :: isSeparator not ] ] ]
		whileTrue:[editor movePointTo: editor point + 1].
		
	self redrawNeeded.
		! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/6/2023 20:46:01'!
handlesKeyboard

	^self visible! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/6/2023 19:05:48'!
handlesMouseDown: aMouseButtonEvent
	^true! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/6/2023 21:12:14'!
handlesMouseOver: aMorphicEvent
	^self visible ! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 6/4/2023 12:04:54'!
keyStroke: aKeyboardEvent

	| cpos |
	
	cpos := page point: text at: editor point.
	
	self doKeyStroke: aKeyboardEvent.
	
	self triggerEvent: #keystroke with: cpos
	
	
	! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/6/2023 21:13:41'!
keyboardFocusChange: aBoolean

	"self halt."! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/21/2023 12:55:22'!
mouseButton1Down: aMouseButtonEvent localPosition: localEventPosition

	| i |

	i := page index: text at: localEventPosition.
	
	editor movePointTo: i; moveMarkTo: i.
	
	aMouseButtonEvent hand 
		waitForClicksOrDragOrSimulatedMouseButton2: self
		event: aMouseButtonEvent
		clkSel: #click:localPosition:
		clkNHalf: nil
		dblClkSel: #doubleClick:localPosition:
		dblClkNHalfSel: nil
		tripleClkSel: nil
		dragSel: nil.
		
	self redrawNeeded.! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/8/2023 15:30:38'!
mouseButton2Activity
	"Invoke the menu"
	self getMenu ifNotNil: [ :menu |
		menu popUpInWorld: self world.
		"menu invokeModal" ]! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 6/4/2023 11:41:46'!
mouseEnter: evt

	evt hand newKeyboardFocus: self! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/12/2023 09:43:50'!
mouseMove: aMouseMoveEvent localPosition: localEventPosition

	aMouseMoveEvent mouseButton1Pressed ifTrue:[
		editor moveMarkTo: (page index: text at: localEventPosition)	. self redrawNeeded 	]! !

!BidiTextMorph methodsFor: 'drawing' stamp: 'DF 4/17/2023 18:39:06'!
debugRects

	| b e rects |
	
	self halt.
	
	b := editor point min: editor mark.
	
	e := editor point max: editor mark.
	
	b = e ifTrue:[^self].
	
	rects := page rectangles: text from: b  to: e.


! !

!BidiTextMorph methodsFor: 'drawing' stamp: 'DF 6/5/2023 15:25:45'!
drawCursorOn: aCanvas

	| aRect |
	
	aRect := page point: text at: editor point.
	
	aRect := aRect translatedBy: leftMargin @0.
		
	aCanvas line: aRect origin to: aRect corner width: 2 color: Color black.! !

!BidiTextMorph methodsFor: 'drawing' stamp: 'DF 6/5/2023 15:20:09'!
drawOn: aCanvas

	super drawOn: aCanvas.

	self drawSelectionOn: aCanvas.
	
	page draw: text on: aCanvas at: leftMargin clip: self topLeftInOwner y @ owner morphExtent y.
	
	self drawCursorOn: aCanvas.
! !

!BidiTextMorph methodsFor: 'drawing' stamp: 'DF 4/12/2023 09:48:57'!
drawSelectionOn: aCanvas

	| b e  rects |
	
	b := editor point min: editor mark.
	
	e := editor point max: editor mark.
	
	b = e ifTrue:[^self].
	
	rects := page rectangles: text from: b  to: e.
	
	rects do:[:each | aCanvas fillRectangle: each color: Color lightBlue ].
! !

!BidiTextMorph methodsFor: 'drawing' stamp: 'DF 6/5/2023 10:16:57'!
extentChanged: oldExtent
	
	"We need to rebuild the page only if the extent's width changes. "
	
	page width: self morphWidth - leftMargin - rightMargin ; build: text ! !

!BidiTextMorph methodsFor: 'initialization' stamp: 'DF 6/5/2023 15:26:35'!
initialize

	super initialize.
	
	color := Color fromHexString: '#ffdeb1'.
	
	text := '' asText.
	
	editor := BidiEditor new.
	
	yoffset := 0.
	
	leftMargin := 5.
	
	rightMargin := 8.

	editor text: text.
	
	page := BidiPage new.
	
	page width: 640 - leftMargin - rightMargin.
		
	page build: text.
	
	! !

!BidiTextMorph methodsFor: 'accessing' stamp: 'DF 6/4/2023 11:52:05'!
cursorRectangle

	^page point: text at: editor point.
! !

!BidiTextMorph methodsFor: 'accessing' stamp: 'DF 5/20/2023 19:01:07'!
text: aText

	text := aText.
	
	editor text: text.
	
	page build: text.! !

!BidiTextMorph methodsFor: 'accessing' stamp: 'DF 6/4/2023 09:43:04'!
textHeight

	^page height! !

!BidiTextMorph methodsFor: 'history' stamp: 'DF 4/11/2023 15:05:50'!
offerUndoHistory! !

!BidiTextMorph methodsFor: 'history' stamp: 'DF 5/20/2023 19:01:02'!
redo

	editor redo.
	
	page build: text.
	
	self redrawNeeded.! !

!BidiTextMorph methodsFor: 'history' stamp: 'DF 5/20/2023 19:01:11'!
undo

	editor undo.
	
	page build: text.
	
	self redrawNeeded.! !

!BidiTextMorph class methodsFor: 'as yet unclassified' stamp: 'DF 6/4/2023 13:45:26'!
example

	"self example"
	
	| s |

	s := '{א} בראשית ברא אלהים את השמים ואת הארץ: {ב} והארץ היתה תהו ובהו וחשך על פני תהום ורוח אלהים מרחפת על פני המים: {ג} ויאמר אלהים יהי אור ויהי אור: {ד} וירא אלהים את האור כי טוב ויבדל אלהים בין האור ובין החשך: {ה} ויקרא אלהים לאור יום ולחשך קרא לילה ויהי ערב ויהי בקר יום אחד: (פ)

פָּנָאיט איסְטְרָטי (1884–1935) היה סופר, עורך עיתון, עיתונאי ופובליציסט יליד רומניה, שעל אף נדודיו שמר על זיקה משמעותית למכורתו. איסטרטי עסק בעשרות משלחי יד, חי במספר ארצות וכתב בשפות הצרפתית והרומנית. יצירתו הייחודית, שניפצה מוסכמות, זכתה לחשיפה רבה ולתרגומים רבים ואף לעיבודים קולנועיים, ואיסטרטי עצמו זכה לכינוי "מקסים גורקי של הבלקנים". הוא היה פעיל פוליטי פציפיסטי וסוציאליסטי, מארגן שביתות והפגנות ונואם המלהיב המונים.

צריח הכנסייה הגבוה ביותר בעולם שייך לקתדרלת אוּלְם שבגרמניה, וגובהו 161.53 מטרים. הצריח הושלם ב-1890 במסגרת גל התחייה הגותית, שבו שופצו והושלמו קתדרלות רבות בגרמניה, צרפת ואיטליה. הקתדרלה לקחה את תואר הבניין הגבוה בעולם מקתדרלת קלן, שהושלמה ב-1880 וגובהה היה 157 מטרים. בשנת 1908 הפסידה קתדרלת אולם את התואר לבניין סינגר בניו יורק שבארצות הברית (שהחזיק בו רק עד 1909). כנסיית סגרדה פמיליה שבברצלונה, שבנייתה נמשכת בימינו, אמורה להגיע לגובה של 170 מטר עם השלמתה ולעבור את קתדרלת אולם. קתדרלת לינקולן הגיעה לגובה של 160 מטר כבר בתחילת המאה ה-14, אך חלקה הגבוה קרס מאוחר יותר.

שוגרה לחלל לעבר כוכב הלכת צדק הגשושית Juice (בתמונה), שפותחה על ידי סוכנות החלל האירופית, ובה גם מכשיר מחקר של סוכנות החלל הישראלית ומכון ויצמן למדע (ynet)

פיזיקה (מהמילה היוונית φυσικός) היא חקר הטבע, במובן הרחב ביותר. פיזיקאים חוקרים את התנהגות החומר והאנרגיה, ואת השפעתם על היקום הסובב אותנו. תאוריות פיזיקליות מתוארות לרוב על ידי משוואות מתמטיות. לתאוריות מבוססות היטב ניתן להתייחס כאל "חוק פיזיקלי", אך כמו כל תאוריה מדעית, ייתכן שהן תשתנינה כתוצאה מתצפיות חדשות, ניסויים או תאוריות מוכללות יותר.

הופעת מכניקת הקוונטים חייבה את קיומה של תאוריה קוונטית של אלקטרומגנטיות. תאוריה זו, שהושלמה בשנת 1970, ידועה בשם "אלקטרודינמיקה קוונטית" (QED). כאשר האור מקיים אינטראקציה עם חומר כמו באפקט הפוטו-אלקטרי, אופיו הקוונטי של האור בא לידי ביטוי. מתורת הקוונטים אנו למדים שהאנרגיה שאור יכול לתת או לקבל מקוונטטת ליחידות של hf כאשר h הוא קבוע פלאנק ו-f היא התדירות. התיאור המלא והנכון ביותר של האור למיטב ידיעתנו הוא של תורת השדות הקוונטית. אין סתירה בינו לבין אופטיקה גאומטרית, למשל. אופטיקה גאומטרית מתלכדת עם התיאור הקוונטי בגבול של אורכי גל קצרים.

Arabic (اَلْعَرَبِيَّةُ, al-ʿarabiyyah [al ʕaraˈbijːa] ; عَرَبِيّ, ʿarabī [ˈʕarabiː] or [ʕaraˈbij]) (sometimes arguably, the Arabic languages) is a Semitic language spoken primarily across the Arab world.[6] Having emerged in the 1st century, it is named after the Arab people; the term "Arab" was initially used to describe those living in the Arabian Peninsula, as perceived by geographers from ancient Greece.[7]'.

BidiScrollableTextMorph new model: s asUnicodeString asText ; morphExtent:800@600;  openInWorld
	! !

!BidiTextMorph class methodsFor: 'as yet unclassified' stamp: 'DF 5/26/2023 18:45:19'!
example2

	"self example2"
	
	| s |

	s := 'In olden times when wishing still helped one, there lived a king whose daughters were all beautiful; and the youngest was so beautiful that the sun itself, which has seen so much, was astonished whenever it shone in here face. 

Close by the king''s castle lay a great dark forest, and under an old lime-tree in the forest was a well, and when the day was very warm, the king''s child went out into the forest and sat down by the side of the cool fountain; and when she was bored she took a golden ball, and threw it up on high and caught it; and this ball was her favorite plaything.'.

	BidiTextMorph new morphExtent:640@480; text:s asUnicodeString asText ; openInWorld
	! !

!ArabicComposer class methodsFor: 'as yet unclassified' stamp: 'DF 4/21/2023 20:23:16'!
compose: aUnicodeString

	^self compose: aUnicodeString from:1 to: aUnicodeString size
! !

!ArabicComposer class methodsFor: 'as yet unclassified' stamp: 'DF 4/21/2023 22:28:45'!
compose: aUnicodeString from: bIndex to:eIndex

	| output b e lookAhead lookBehind |
	
	b := 1570.
	e := 1610.
	
	output := OrderedCollection new.
	
	bIndex to: 	eIndex do:[:i |
		
		b <= (aUnicodeString at:i) codePoint and:[(aUnicodeString at:i) codePoint <= e] :: 
			ifTrue:[
				
				lookAhead := i + 1.
				
				[lookAhead <= aUnicodeString size and:[self isDiacritic: (aUnicodeString at:lookAhead)] ]
					whileTrue:[lookAhead := lookAhead + 1].
				
				lookBehind := i - 1.
				
				[lookBehind >=1 and:[self isDiacritic: (aUnicodeString at:lookBehind)] ]
					whileTrue:[lookBehind := lookBehind - 1].
							
				"beginning of word"
				(i = 1 or: [ self isLetter: (aUnicodeString at:lookBehind) :: not ]) and: [i < aUnicodeString size] and: [ self isLetter: (aUnicodeString at: lookAhead) ] :: ifTrue:[ | c | 
					c := Beginning at: (aUnicodeString at:i) codePoint - 1569.
					c ifNil:[output add: (aUnicodeString at:i) ] ifNotNil:[output add: (UnicodeCodePoint codePoint: c + 65165)] ].
				
				"middle of word"
				i > 1 and: [i < aUnicodeString size] and: [self isLetter:(aUnicodeString at:lookBehind) ] and: [self isLetter: (aUnicodeString at:lookAhead) ] :: ifTrue:[ | c |
					
					c := Middle at: (aUnicodeString at:i) codePoint - 1569.
					c ifNil:[output add: (aUnicodeString at:i) ] ifNotNil:[output add: (UnicodeCodePoint codePoint: c + 65165)] ].
				
				"end of word" 
				i> 1 and:[ self isLetter: (aUnicodeString at:lookBehind) ] and: [i = aUnicodeString size or: [ self isLetter: (aUnicodeString at: lookAhead) :: not ] ] :: ifTrue:[
					| c |
					
					c := End at: (aUnicodeString at:i) codePoint - 1569.
					c ifNil:[output add: (aUnicodeString at:i) ] ifNotNil:[output add: (UnicodeCodePoint codePoint: c + 65165)]
					].
				
				"isolated"
				
				(i = 1 or: [ self isLetter: (aUnicodeString at: lookBehind) :: not ]) and: [i = aUnicodeString size or: [ self isLetter: (aUnicodeString at: lookAhead) :: not ] ] :: ifTrue:[
					| c |
					
					c := Isolated at: (aUnicodeString at:i) codePoint - 1569.
					c ifNil:[output add: (aUnicodeString at:i) ] ifNotNil:[output add: (UnicodeCodePoint codePoint: c + 65165)]
					].
			] 
			ifFalse:[output add: (aUnicodeString at:i) ] ].
	
	^UnicodeString newFrom: output! !

!ArabicComposer class methodsFor: 'as yet unclassified' stamp: 'DF 4/10/2023 20:26:16'!
initialize

	"self initialize"
	
	Isolated := #( -12 nil nil nil nil 0 2 6 8 12 16 20 24 28 30 32 34 36 40 44 48 52 56 60 64 nil nil nil nil nil nil 68 72 76 80 84 88 92 96 98 100).
	
	End := #(-11 nil nil nil nil 1 3 7 9 13 17 21 25 29 31 33 35 37 41 45 49 53 57 61 65 nil nil nil nil nil nil 69 73 77 81 85 89 93 97 99 101).
	
	Beginning := #(nil nil nil nil nil nil 4 nil 10 14 18 22 26 nil nil nil nil 38 42 46 50 54 58 62 66 nil nil nil nil nil nil 70 74 78 82 86 90 94 nil nil 102).
	
	Middle := #(nil nil nil nil nil nil 5 nil 11 15 19 23 27 nil nil nil nil 39 43 47 51 55 59 63 67 nil nil nil nil nil nil 71 75 79 83 87 91 95 nil nil 103).! !

!ArabicComposer class methodsFor: 'as yet unclassified' stamp: 'DF 4/21/2023 20:35:57'!
isDiacritic: aUnicodeCodePoint

	^ 0x064B <= aUnicodeCodePoint codePoint and: [aUnicodeCodePoint codePoint <= 0x065F]! !

!ArabicComposer class methodsFor: 'as yet unclassified' stamp: 'DF 4/21/2023 21:55:08'!
isLetter: aUnicodeCodePoint

	^ 0x0627 <= aUnicodeCodePoint codePoint and: [aUnicodeCodePoint codePoint <= 0x064A]! !

!BidiEditor methodsFor: 'initialization' stamp: 'DF 4/11/2023 13:55:57'!
initialize
	point := 1.
	mark := 1.
	history := ReadWriteStream on:#().! !

!BidiEditor methodsFor: 'accessing' stamp: 'DF 4/6/2023 19:25:07'!
mark
	^mark! !

!BidiEditor methodsFor: 'accessing' stamp: 'DF 4/6/2023 19:25:05'!
point
	^point! !

!BidiEditor methodsFor: 'accessing' stamp: 'DF 4/8/2023 16:03:00'!
selection
	
	| b e |
	
	b := mark min: point.
	e := mark max: point.
	
	^text copyFrom:b to:e - 1.
! !

!BidiEditor methodsFor: 'accessing' stamp: 'DF 4/3/2023 21:19:32'!
text: aText
	text := aText! !

!BidiEditor methodsFor: 'editing' stamp: 'DF 5/27/2023 21:22:44'!
align: aSymbol

	| b e align aCommand |
	
	b := point min: mark.
	e := point max: mark.

	aSymbol = #center ifTrue:[align := TextAlignment centered].
	aSymbol = #left ifTrue:[align := TextAlignment leftFlush].
	aSymbol = #right ifTrue:[align := TextAlignment rightFlush].
	aSymbol = #justified ifTrue:[align := TextAlignment justified].
	
	aCommand := text commandForAddAttribute: align from: b to: e-1.
	
	history nextPut: aCommand; truncateAtPosition.	
	aCommand doOn: self.
	! !

!BidiEditor methodsFor: 'editing' stamp: 'DF 5/7/2023 20:30:22'!
backspace

	| delta |
	
	mark = point ifTrue:[self moveMarkTo: point - 1].
	
	delta := self replaceSelectionWith: ''.
	
	self movePointTo: (point min: mark).
	self moveMarkTo: point.
	
	^delta
! !

!BidiEditor methodsFor: 'editing' stamp: 'DF 5/6/2023 13:34:44'!
basicReplaceAttributesFrom: start to: stop with: replacement

	text basicReplaceAttributesFrom: start to: stop with: replacement! !

!BidiEditor methodsFor: 'editing' stamp: 'DF 4/11/2023 14:16:08'!
basicReplaceFrom: start to: stop with: replacement
	"As requested. Basic service used by Undo / Redo. Does not genertate undo."

	text replaceFrom: start to: stop with: replacement! !

!BidiEditor methodsFor: 'editing' stamp: 'DF 5/7/2023 20:44:18'!
delete

	| delta |
	
	mark = point ifTrue:[self movePointTo: point + 1].
	
	delta := self replaceSelectionWith: ''.
	
	self movePointTo: (point min: mark).
	self moveMarkTo: point.
	
	^delta
! !

!BidiEditor methodsFor: 'editing' stamp: 'DF 5/6/2023 17:54:31'!
insert: aCodePoint

	| p attrs t delta | 

	"when we insert a aCodePoint we want it to have the style of the text immediately before it."

	p := point min: mark.
	
	attrs := p = 1 ifTrue:[#()] ifFalse:[text attributesAt: p-1].	
	t := aCodePoint asUnicodeCodePoint asText.
	attrs do:[:each | t addAttribute: each].
	
	delta := self replaceSelectionWith: t.
	self movePointTo: p + 1.
	self moveMarkTo: point.

	^delta! !

!BidiEditor methodsFor: 'editing' stamp: 'DF 5/7/2023 20:55:21'!
paste: aText

	"Paste aText over the current selection."
	
	| delta |
	
	delta := self replaceSelectionWith: aText.
	
	self movePointTo: point + aText size ; moveMarkTo: point. 
	
	^delta ! !

!BidiEditor methodsFor: 'editing' stamp: 'DF 6/2/2023 18:12:33'!
replaceSelectionWith: aText

	| b e aCommand |
	
	b := mark min: point.
	e := mark max: point.
	
	aCommand := text commandForReplaceFrom: b to: e-1  with: aText asUnicodeStringOrText.
	
	b = e and:[ history isEmpty not] and: [ history peekLast isKindOf: TextReplaceCommand] and: [ history peekLast stopPosition = e ] :: 
		ifTrue:[
			history peekLast appendToNew: aText ]
		ifFalse:[
			history nextPut: aCommand; truncateAtPosition.	"To disable redo of previous commands, now invalidated." ].
	
	aCommand doOn: self.
	
	^ aText size - (e - b)
	
	! !

!BidiEditor methodsFor: 'point & mark' stamp: 'DF 4/9/2023 18:16:12'!
decrementPointMark

	self movePointTo: point - 1;  moveMarkTo: point 		! !

!BidiEditor methodsFor: 'point & mark' stamp: 'DF 4/11/2023 12:35:35'!
moveMarkTo: anInteger
	mark := anInteger min: text size + 1  :: max: 1! !

!BidiEditor methodsFor: 'point & mark' stamp: 'DF 4/11/2023 12:35:39'!
movePointTo: anInteger
	
	point := anInteger min: text size + 1 :: max: 1! !

!BidiEditor methodsFor: 'history' stamp: 'DF 4/11/2023 15:17:27'!
redo

	| p |
	
	history atEnd ifTrue:[^self].
	
	p := history next doOn: self.
	
	self movePointTo: p ; moveMarkTo: p. ! !

!BidiEditor methodsFor: 'history' stamp: 'DF 4/11/2023 14:40:01'!
undo

	| p |
	
	history position = 0 ifTrue:[^self].
	
	history skipBack.
	
	p := history peek undoOn: self.
	
	self movePointTo: p; moveMarkTo: p.! !

!BidiFork methodsFor: 'as yet unclassified' stamp: 'DF 4/22/2023 16:16:30'!
count
	^count! !

!BidiFork methodsFor: 'as yet unclassified' stamp: 'DF 4/23/2023 21:36:22'!
first
	| p |
	
	p := self.
	
	[p left notNil] whileTrue:[p := p left].
	
	^p! !

!BidiFork methodsFor: 'as yet unclassified' stamp: 'DF 4/22/2023 16:18:13'!
height
	^height! !

!BidiFork methodsFor: 'as yet unclassified' stamp: 'DF 4/23/2023 21:36:31'!
last
	| p |
	
	p := self.
	
	[p right notNil] whileTrue:[p := p right].
	
	^p! !

!BidiFork methodsFor: 'as yet unclassified' stamp: 'DF 4/22/2023 22:01:02'!
left
	^left! !

!BidiFork methodsFor: 'as yet unclassified' stamp: 'DF 4/22/2023 22:10:09'!
left: aNode right: anotherNode

	left := aNode.
	right := anotherNode.
	
	left parent: self.
	right parent: self.
	
	self update.! !

!BidiFork methodsFor: 'as yet unclassified' stamp: 'DF 4/22/2023 21:29:34'!
paragraphAt: anIndex

	anIndex <= weight ifTrue:[^left paragraphAt:anIndex].
	
	^right paragraphAt: anIndex - weight.! !

!BidiFork methodsFor: 'as yet unclassified' stamp: 'DF 4/22/2023 22:00:58'!
parent
	^parent! !

!BidiFork methodsFor: 'as yet unclassified' stamp: 'DF 4/22/2023 16:15:26'!
parent: aNode

	parent := aNode
	! !

!BidiFork methodsFor: 'as yet unclassified' stamp: 'DF 4/22/2023 22:01:05'!
right
	^right! !

!BidiFork methodsFor: 'as yet unclassified' stamp: 'DF 4/22/2023 22:10:04'!
update
	
	weight := left count.
	count := left count + right count.
	height := left height + right height.! !

!BidiFork class methodsFor: 'as yet unclassified' stamp: 'DF 4/22/2023 16:14:40'!
build: anOrderedCollection from: bIndex to: eIndex

	| m x y |
	
	self assert: bIndex >=1.
	self assert: bIndex <= eIndex.
	self assert: eIndex <= (anOrderedCollection size + 1).
	
	eIndex == bIndex ifTrue:[^nil].
	
	eIndex == (bIndex + 1) ifTrue:[^anOrderedCollection at: bIndex].
	
	m := (bIndex // 2) + (eIndex // 2) + (( (bIndex mod:2)  + (eIndex mod:2) ) // 2).
	
	self assert: bIndex < m.
	self assert: eIndex > m.
	
	x := self build: anOrderedCollection from: bIndex to: m.
	y := self build: anOrderedCollection from:m to: eIndex.
	
	^BidiFork new left: x right: y ; yourself
	! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 5/19/2023 17:55:29'!
ascent
	^metrics ascent! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 5/19/2023 17:55:40'!
ascent: aNumber
	metrics ascent: aNumber! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 4/15/2023 13:36:33'!
beginIndex
	^zones first beginIndex! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 5/19/2023 17:55:47'!
descent
	^metrics descent! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 5/19/2023 17:55:58'!
descent: aNumber
	metrics descent: aNumber! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 4/15/2023 18:01:08'!
endIndex
	^zones last endIndex! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 5/19/2023 17:56:24'!
extent: aPoint
	metrics width: aPoint x ; height: aPoint y! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 5/19/2023 17:56:31'!
height
	^metrics height! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 6/3/2023 17:17:05'!
newlineTerminated

	^newlineTerminated ! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 6/3/2023 17:17:50'!
newlineTerminated: aBoolean

	newlineTerminated := aBoolean! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 5/19/2023 17:56:38'!
width
	^metrics width! !

!BidiLine methodsFor: 'building' stamp: 'DF 5/22/2023 18:48:00'!
build: tokens base: baseIndex from: bIndex to: e direction: dir ratio: stretchRatio 

	| b zone |
	
	self assert: bIndex <= tokens size.

	bIndex = e ifTrue:[^self emptyAt: (tokens at: bIndex) begin - baseIndex].
	
	self assert: bIndex < e.
	
	zones removeAll.
	
	b := bIndex.
	
	[b < e ] 
		whileTrue:[
			zone := BidiZone from: (tokens at:b) direction: dir.
			zones add: zone.
			b := zone build: tokens base: baseIndex from: b to: e direction: dir ratio: stretchRatio ].
	
	metrics := zones inject: (BidiTextMetrics new width:0 ; height:0 ; ascent:0 ; descent:0 ; yourself) into:[:acc :each | acc encompass: each].
	
			 ! !

!BidiLine methodsFor: 'building' stamp: 'DF 5/19/2023 17:56:59'!
emptyAt: anIndex

	| aZone |
	
	aZone := BidiZone emptyAt: anIndex. 
	
	metrics := aZone metrics.
	
	zones removeAll; add: aZone.
	
	
! !

!BidiLine methodsFor: 'drawing' stamp: 'DF 6/5/2023 15:13:29'!
draw: aText from: baseIndex on: aCanvas at: aPoint direction: direction width: width alignment: alignment  

	| x xoffset y |
	
	y := aPoint y.
	
	x := direction = 1 ifTrue:[0] ifFalse:[width].
	
	xoffset := self xoffset: direction width: width alignment: alignment.
	
	x := xoffset * direction + x + aPoint x.
	
	zones do:[:each |
		each draw: aText from: baseIndex on: aCanvas at: (x@y) direction: direction.
		x := x + (each width * direction) ].
		
! !

!BidiLine methodsFor: 'drawing' stamp: 'DF 5/27/2023 21:24:29'!
xoffset: direction width: width alignment: alignment

	alignment isNil ifTrue:[^0].

	alignment = #justified ifTrue:[^0]. 
	
	alignment = #left and: [direction = 1] :: ifTrue:[^0]. 

	alignment = #right and:[direction = -1] :: ifTrue:[^0].
		
	alignment = #center 		ifTrue:[^(width - metrics width) // 2].
	
	^width - metrics width.
! !

!BidiLine methodsFor: 'translating' stamp: 'DF 4/28/2023 14:44:15'!
index: aText base: anInteger direction: direction width: width at: xCoord alignment: alignment 

	| x xoffset i |
	
	self assert: xCoord >= 0.
	
	x := direction = 1 ifTrue:[0] ifFalse:[width].

	xoffset := self xoffset: direction width: width alignment: alignment.
	
	x := xoffset * direction + x.
	 
	i := 1.
	
	[i <= zones size and: [ (xCoord * direction) > (((zones at:i :: width) * direction + x) * direction) ] ] 
		whileTrue:[ x := x + ((zones at:i :: width) * direction). i := i + 1].

	i <= zones size 	
		ifTrue:[^ zones at:i :: index: aText base: anInteger direction:direction width: x at: xCoord].
		
	^ zones last endIndex + anInteger.
		
! !

!BidiLine methodsFor: 'translating' stamp: 'DF 5/6/2023 12:48:30'!
rectangles: aText base: baseIndex from: bIndex to: eIndex at: y direction: direction width: width alignment: alignment 

	| x xoffset |
	
	x := direction = 1 ifTrue:[0] ifFalse:[width].

	xoffset := self xoffset: direction width: width alignment: alignment.
	
	x := xoffset * direction + x.

	^zones inject: OrderedCollection new into:[:acc :each | acc addAll: (each rectangles: aText base:baseIndex from: bIndex to:eIndex at: (x@y) direction: direction). x := x + (each width * direction). acc ].
	! !

!BidiLine methodsFor: 'translating' stamp: 'DF 5/19/2023 18:40:21'!
xcoord: aText direction: direction base: baseIndex at: index width: width alignment: alignment 

	" answer the x coordinate of the code point whose index is index. "	
	
	| i x xoffset |
	
	i := 1.
	x := direction = 1 ifTrue:[0] ifFalse:[width].

	xoffset := self xoffset: direction width: width alignment: alignment.
	
	x := xoffset * direction + x.
	
	[i <= zones size and: [index >= (zones at:i :: endIndex)] ] 
		whileTrue:[x := x + ((zones at:i :: width) * direction). i := i + 1. ].
	
	i = (zones size + 1) 
		ifTrue:[^x].
	
	^ zones at:i :: xcoord: aText direction: direction base: baseIndex at: index x: x

		! !

!BidiLine methodsFor: 'initialization' stamp: 'DF 6/3/2023 17:16:20'!
initialize

	zones := OrderedCollection new.
	
	newlineTerminated := false.! !

!BidiLine methodsFor: 'testing' stamp: 'DF 6/3/2023 15:27:46'!
isEmpty
	^self beginIndex = self endIndex! !

!BidiLine class methodsFor: 'instance creation' stamp: 'DF 4/15/2023 13:57:28'!
emptyAt: anIndex

	| aLine |
	
	aLine := self new.
	 
	aLine emptyAt: anIndex.
	
	^aLine! !

!BidiLineBreak methodsFor: 'as yet unclassified' stamp: 'DF 6/3/2023 17:18:02'!
buildLine: tokens base: baseIndex direction: direction

	| line |
	
	line := BidiLine new.
	line newlineTerminated: newlineTerminated. 
	line build: tokens base: baseIndex from: from to: to direction: direction ratio: 0.

	^line! !

!BidiLineBreak methodsFor: 'as yet unclassified' stamp: 'DF 5/20/2023 15:58:19'!
from
	^from! !

!BidiLineBreak methodsFor: 'as yet unclassified' stamp: 'DF 5/20/2023 15:58:11'!
from: anIndex
	from := anIndex! !

!BidiLineBreak methodsFor: 'as yet unclassified' stamp: 'DF 6/3/2023 17:12:36'!
initialize

	newlineTerminated := false.! !

!BidiLineBreak methodsFor: 'as yet unclassified' stamp: 'DF 6/3/2023 17:13:12'!
setAsNewlineTerminated

	newlineTerminated := true! !

!BidiLineBreak methodsFor: 'as yet unclassified' stamp: 'DF 5/20/2023 15:58:21'!
to
	^to! !

!BidiLineBreak methodsFor: 'as yet unclassified' stamp: 'DF 5/20/2023 15:58:16'!
to: anIndex
	to := anIndex! !

!BidiJustifiedLineBreak methodsFor: 'as yet unclassified' stamp: 'DF 5/22/2023 18:56:03'!
buildLine: tokens base: baseIndex direction: direction

	| line factor |
	
	line := BidiLine new.
	
	factor := ratio <= 0 ifTrue:[shrink] ifFalse:[stretch].
	
	line build: tokens base: baseIndex from: from to: to direction: direction ratio: factor * ratio.

	^line! !

!BidiJustifiedLineBreak methodsFor: 'as yet unclassified' stamp: 'DF 5/22/2023 18:01:45'!
ratio
	^ratio! !

!BidiJustifiedLineBreak methodsFor: 'as yet unclassified' stamp: 'DF 5/22/2023 19:23:22'!
ratio: aNumber
	ratio := aNumber! !

!BidiJustifiedLineBreak methodsFor: 'as yet unclassified' stamp: 'DF 5/22/2023 18:55:09'!
shrink: aNumber
	shrink := aNumber! !

!BidiJustifiedLineBreak methodsFor: 'as yet unclassified' stamp: 'DF 5/22/2023 18:55:02'!
stretch: aNumber
	stretch := aNumber! !

!BidiLineBreaker methodsFor: 'as yet unclassified' stamp: 'DF 5/22/2023 18:22:11'!
break: tokens 
	
	self subclassResponsibility ! !

!BidiLineBreaker methodsFor: 'as yet unclassified' stamp: 'DF 5/22/2023 18:30:30'!
width: aNumber
	width := aNumber! !

!BidiJustifiedLineBreaker methodsFor: 'as yet unclassified' stamp: 'DF 6/3/2023 18:31:19'!
break: tokens 

	| edges indices graph vertices breaks last p path result t |
	
	edges := self potentialBreaks: tokens tolerance: 8. 
	
	indices := edges inject: Set new into:[:acc :each | acc add: each from. acc add:each to. acc].
	
	vertices := Dictionary new.

	indices do:[:each | vertices at: each put:(Vertex new key: each; yourself)].
	
	breaks := Dictionary new.
	
	edges do:[:each | | u v e | 
		u := vertices at: (each from). 
		v := vertices at: (each to).
		e := Edge new weight: (each ratio); connect: u to: v.
		breaks at: e put: each. ]. 
	
	graph := Graph new.
		
	vertices do:[:each | graph addVertex: each ].
	
	last := indices max.
	
	graph shortestPathFrom: (vertices at:1) to: last weightFunction: [:r| 100 * (r abs raisedTo:3)]. 
	
	path := OrderedCollection new.
	
	p := (vertices at:last).
	
	[p prev notNil ] 
		whileTrue:[path add: p prev. p := (p prev) from ].
		
	result := path reverse collect:[:each | breaks at: each].
	
	"create line breaks for as many newlines as there are at the end"
	
	t := result last to + 1.
	
	[t <= tokens size and:[tokens at: t :: tag = #nl ] ] 
		whileTrue:[
			result add: (BidiLineBreak new from: t ; to: t; setAsNewlineTerminated; yourself).
			t := t + 1].
	
	^result	
	! !

!BidiJustifiedLineBreaker methodsFor: 'as yet unclassified' stamp: 'DF 5/23/2023 21:06:43'!
nextPotentialBreak: tokens after: index 
	
	|i | 
	
	i := index.

	[i <= tokens size and: [tokens at:i :: tag = #word or:[tokens at:i :: tag = #contra] ] ]
		whileTrue:[i := i + 1].

	[i <= tokens size and:[tokens at: i :: isSeparator] ] 
		whileTrue:[ i := i + 1. ].
		
	i <= tokens size and:[tokens at:i :: tag = #eot] :: ifTrue:[i := i 	+ 1].
			
	^i.
! !

!BidiJustifiedLineBreaker methodsFor: 'as yet unclassified' stamp: 'DF 6/3/2023 18:31:59'!
potentialBreaks: tokens tolerance: tol

	|  b breaks active |
	
	breaks := OrderedCollection new.

	tokens isEmpty ifTrue:[^breaks].
	
	b := 1. 
	
	active := Set new.
	
	active add: b. 
	
	b := self nextPotentialBreak: tokens after: b. 
	
	[b <= tokens size] 
		whileTrue:[ | keep | 
			keep := Set new.
			active do:[:each | | r |
				r := self skipRatio: tokens from: each to: b-1.
				r >= -1 
					ifTrue:[keep add: each]. 
				-1 <= r and:[ r <= tol] :: ifTrue:[
					breaks add: (BidiJustifiedLineBreak new from: each ; stretch: stretch; shrink: shrink; ratio: r ; to: b; yourself).  
					keep add: b] ].
			keep isEmpty "prevent active from becoming empty even at the cost of bad breaks"
				ifTrue:[self halt]. 
			active := keep. 
			b := self nextPotentialBreak: tokens after: b ].
	
	"find the point after which there are only newlines. "
	
	[b > 1 and:[tokens at: b - 1 :: tag = #nl] ] whileTrue:[b := b - 1].
	
	active do:[ :each | | r |
		r := self skipRatio: tokens from: each to: b-1.
		r >= 0 ifTrue:[ "add any breaks that do not require shrinking. we don't care about stretching because this is the last line"
			breaks add:(BidiJustifiedLineBreak new from: each ; stretch: stretch; shrink: shrink; ratio: 0 ; to: b; yourself)		] ].
	
	^breaks
	
	
	
	
	! !

!BidiJustifiedLineBreaker methodsFor: 'as yet unclassified' stamp: 'DF 5/22/2023 18:59:42'!
shrink: aNumber
	shrink := aNumber! !

!BidiJustifiedLineBreaker methodsFor: 'as yet unclassified' stamp: 'DF 5/22/2023 18:35:15'!
skipRatio: tokens from: begin to: end 

	| actual b w ws |

	actual := 0.
	b := begin.
	[b < end] whileTrue:[
		actual := actual + (tokens at:b :: metrics width). 
		b := b + 1. ].

	w := actual > width "shrinking" ifTrue:[shrink] ifFalse:[stretch].
	
	ws := 0.
	b := begin.
	[b < end] 
		whileTrue:[ | t | 
			t := tokens at:b.
			t tag = #ws or:[ t tag = #nl] ::
				ifTrue:[ws := ws + (t metrics width) ].
			b := b+ 1. ].

	^ (width - actual) / (w * ws)! !

!BidiJustifiedLineBreaker methodsFor: 'as yet unclassified' stamp: 'DF 5/22/2023 18:59:34'!
stretch: aNumber
	stretch := aNumber! !

!BidiRaggedLineBreaker methodsFor: 'as yet unclassified' stamp: 'DF 6/3/2023 17:15:09'!
break: tokens 

	| b w breaks |
	
	breaks := OrderedCollection new.
	
	b := 1.
	
	[ b <= tokens size ] 
		whileTrue:[ | p pp aBreak |
			pp := b.
			p := self nextBreak: tokens after: pp.
			w := self width: tokens from: pp to: p.
			
			[p <= tokens size and:[w <= width] and:[ tokens at: p :: tag ~= #nl ] ]
				whileTrue:[
					pp := p.  
					p := self nextBreak: tokens after:p.
					w := w + (self width: tokens from:pp to:p) ].
			
			w > width ifTrue:[p := pp].
			
			aBreak := BidiLineBreak new from: b ; to: p ; yourself.
			
			breaks add:aBreak.
			p <= tokens size and:[tokens at:p :: tag = #nl] :: 
				ifTrue:[
					aBreak setAsNewlineTerminated. 
					p := p + 1]. "skip the newline character"
			b := p ]. 
	
	^breaks
	! !

!BidiRaggedLineBreaker methodsFor: 'as yet unclassified' stamp: 'DF 5/21/2023 09:34:19'!
nextBreak: tokens after: index

	| b |
	
	b := index.
	
	[b <= tokens size and:[tokens at:b :: isSeparator not ] ] whileTrue:[b := b + 1].

	[b <= tokens size and:[tokens at:b :: tag = #ws ] ] whileTrue:[b := b + 1].
	
	^b.! !

!BidiRaggedLineBreaker methodsFor: 'as yet unclassified' stamp: 'DF 5/20/2023 21:26:19'!
width: tokens from: bIndex to: e

	| b w |
	
	b := bIndex.
	w := 0.
	
	[b < e] whileTrue:[w := w + (tokens at: b :: width). b := b + 1].
	
	^w.! !

!BidiPage methodsFor: 'accessing' stamp: 'DF 6/4/2023 09:38:21'!
height

	^paragraphs inject:0 into:[:acc :each | acc + each height].! !

!BidiPage methodsFor: 'accessing' stamp: 'DF 4/11/2023 15:46:43'!
width: anInteger
	width := anInteger! !

!BidiPage methodsFor: 'as yet unclassified' stamp: 'DF 4/12/2023 12:57:40'!
writingDirectionAt: anIndex

	| i icy |
	
	paragraphs isEmpty ifTrue:[^1]. "default to left-to-right"
	
	icy := self paragraphAt: anIndex.
	
	i := icy at:1.
	
	i = (paragraphs size + 1) ifTrue:[i := i - 1]. "past the end of text, use writing direction of last paragraph"
	
	^ paragraphs at: i :: writingDirection! !

!BidiPage methodsFor: 'translating' stamp: 'DF 4/16/2023 11:52:29'!
above: aText at: anIndex

	| pc p c i |

	pc := self paragraphAt: anIndex.
	
	p := pc at:1.
	c := pc at:2.
	
	i := p <= paragraphs size 
		ifTrue:[	paragraphs at:p :: above: aText at: anIndex - c] ifFalse:[paragraphs last aboveLastLine].
	
	i ifNotNil:[^c + i].
	
	p = 1 ifTrue:[^ anIndex ].
	
	c := c - (paragraphs at: p - 1 :: count).
	
	^ c + (paragraphs at: p-1 :: endIndex)
	! !

!BidiPage methodsFor: 'translating' stamp: 'DF 4/12/2023 15:37:47'!
below: aText at: anIndex

	| pc p c i |

	pc := self paragraphAt: anIndex.
	
	p := pc at:1.
	c := pc at:2.
	
	p = (paragraphs size + 1) ifTrue:[^ anIndex].
	
	i := paragraphs at:p :: below: aText at: anIndex - c.
	
	i ifNotNil:[^c + i].
	
	p = paragraphs size ifTrue:[^ anIndex ].
	
	c := c + (paragraphs at: p :: count).
	
	^ c + (paragraphs at: p+1 :: beginIndex)
	! !

!BidiPage methodsFor: 'translating' stamp: 'DF 4/21/2023 12:55:09'!
index: aText at: aPoint

	| y i c |

	self assert: aPoint y >= 0.
	
	y := 0.
	
	c := 0.
	
	i := 1.
	
	[i <= paragraphs size and: [aPoint y > ((paragraphs at:i :: height) + y) ] ] 
		whileTrue:[ y := y + (paragraphs at:i :: height). c := c + (paragraphs at:i :: count) . i := i + 1].

	i <= paragraphs size 	
		ifTrue:[^ paragraphs at:i :: index: aText base: c at: aPoint - (0@y)].
		
	paragraphs isEmpty ifTrue:[^1].
	
	^ c + paragraphs last endIndex.
! !

!BidiPage methodsFor: 'translating' stamp: 'DF 6/3/2023 19:39:53'!
lastParagraph

	| i c y |
	
	i := 1.
	
	c := 0.
	
	y := 0.
	
	[i < paragraphs size ]
		whileTrue:[c := c + (paragraphs at:i :: count). y := y + (paragraphs at:i :: height). i := i + 1.   ].
		
	^ { i . c . y }
	! !

!BidiPage methodsFor: 'translating' stamp: 'DF 6/3/2023 17:38:35'!
paragraphAt: charIndex

	| i c y |
	
	i := 1.
	
	c := 0.
	
	y := 0.
	
	[i <= paragraphs size and: [paragraphs at: i :: count + c <  charIndex] ]
		whileTrue:[c := c + (paragraphs at:i :: count). y := y + (paragraphs at:i :: height). i := i + 1.   ].
		
	^ { i . c . y }
	! !

!BidiPage methodsFor: 'translating' stamp: 'DF 4/27/2023 19:35:23'!
paragraphsFrom: bIndex to: eIndex do: aBlock

	| bcy ecy b e |
		
	bcy := self paragraphAt: bIndex.
	
	ecy := self paragraphAt: eIndex.
	
	b := bcy at:1.
	
	e := ecy at:1.
	
	^paragraphs from: b to: e do: aBlock.
	



	! !

!BidiPage methodsFor: 'translating' stamp: 'DF 6/5/2023 09:56:46'!
point: aText at: absoluteIndex

	| i c y icy |

	icy := self paragraphAt: absoluteIndex.
	
	i := icy at:1.
	
	c := icy at:2.
	
	y := icy at:3.

	i = (paragraphs size + 1) "point is past the last character in the text"
		ifTrue:[
			paragraphs isEmpty
				ifTrue:[ | metrics |
					metrics := BidiTextMetrics empty.
					^0@(metrics height - metrics ascent) extent: 0@(metrics ascent + metrics descent)					]
				ifFalse:[
					^(paragraphs last lastPoint: aText base: c) translatedBy: (0@y) ] ].

	self assert: i <= paragraphs size.
	
	^ (paragraphs at: i :: point: aText base: c at: absoluteIndex - c) translatedBy: (0@y).
	! !

!BidiPage methodsFor: 'translating' stamp: 'DF 4/12/2023 13:13:54'!
rectangles: aText from: bIndex to: eIndex

	| bcy ecy y c b e i rects |
	
	bcy := self paragraphAt: bIndex.
	
	ecy := self paragraphAt: eIndex.
	
	b := bcy at:1.

	c := bcy at:2.
	
	y := bcy at:3.
	
	e := ecy at:1 :: min: paragraphs size.
		
	i := bIndex.
	
	rects := OrderedCollection new.
	
	b to:e do:[:k | | p pe r |
		p := paragraphs at: k.
		pe := p endIndex min: eIndex - c.
		r := p rectangles: aText base: c from: i - c to: pe.
		rects addAll: (r collect:[:each | each translatedBy: 0@y]).
		i := pe + c + 1.
		c := c + p count.
		y := y + p height].
	
	^rects 
		
			
	! !

!BidiPage methodsFor: 'building' stamp: 'DF 6/3/2023 17:53:00'!
build: aText

	paragraphs removeAll.
	
	paragraphs add: BidiParagraph empty. 
	
	self build: aText from: 0 to: 0 delta: aText size.	! !

!BidiPage methodsFor: 'building' stamp: 'DF 6/3/2023 20:35:15'!
build: aText from: bIndex to:eIndex delta: delta

	| b e bc ec pb pe prefix fresh suffix |
	
	paragraphs isEmpty ifTrue:[paragraphs add:(BidiParagraph empty)].
		
	bc := self paragraphAt: bIndex.
	
	(bc at:1) > paragraphs size ifTrue:[bc := self lastParagraph].
	
	ec := self paragraphAt: eIndex.

	(ec at:1 ) > paragraphs size ifTrue:[ ec := self lastParagraph].
	
	pb := bc at:1.
	
	pe := ec at:1.
	
	prefix := paragraphs copyFrom: 1 to: pb - 1.

	b := paragraphs at: pb :: beginIndex + (bc at:2).

	e := paragraphs at: pe :: terminalIndex + (ec at:2).	
	
	fresh := self parse: aText from: b to: e + delta direction: 1.
	
	suffix := paragraphs copyFrom: pe + 1 to: paragraphs size.
	
	paragraphs := prefix.
	
	paragraphs addAll: fresh; addAll: suffix.
	
	! !

!BidiPage methodsFor: 'building' stamp: 'DF 5/26/2023 20:49:07'!
parse: aText from: b to: e direction: direction

	| i aParagraph anOrderedCollection dir |
	
	dir := direction.
	i := b.
	
	anOrderedCollection := OrderedCollection new.
	
	[ i ~= e ]
		whileTrue:[
			aParagraph := BidiParagraph new width: width; writingDirection: dir.
			i := aParagraph build: aText from: i to: e.
			anOrderedCollection add: aParagraph.
			dir := aParagraph writingDirection ].

	^ anOrderedCollection ! !

!BidiPage methodsFor: 'initialization' stamp: 'DF 4/11/2023 15:46:54'!
initialize

	paragraphs := OrderedCollection new.
	
	width := 640.! !

!BidiPage methodsFor: 'drawing' stamp: 'DF 6/5/2023 15:20:07'!
draw: aText on: aCanvas at: x clip: yh

	| i y |
	
	paragraphs isEmpty ifTrue:[^self].
	
	y := 0.
	i := 0.
	
	paragraphs do:[:each |
		each draw: aText from: i on: aCanvas at: x@y clip: yh.
		y := y + each height.
		i := i + each count].
! !

!BidiParagraph methodsFor: 'drawing' stamp: 'DF 6/5/2023 15:16:57'!
draw: aText from: baseIndex on: aCanvas at: aPoint clip: yh 

	| p y0 |

	y0 := aPoint y.
	
	y0 + yh x + height < 0 ifTrue:[^self].

	y0 + yh x > yh y ifTrue:[^self].
	
	lines isEmpty ifTrue:[^self].
	
	p := aPoint x @ y0.
		
	lines do:[:each |
		p := p + (0 @ each height).
		each draw: aText from: baseIndex on: aCanvas at: p direction: direction width: width alignment: alignment		].
	! !

!BidiParagraph methodsFor: 'initialization' stamp: 'DF 4/11/2023 16:47:43'!
initialize

	direction := 1.
	
	lines := OrderedCollection new.
	
	height := 0.! !

!BidiParagraph methodsFor: 'building' stamp: 'DF 5/27/2023 21:20:37'!
build: aText from: bIndex to: eIndex

	| tokens breaker breaks base |

	"A pargraph contains all characters until the first non line separator after
	two or more line separators."
	
	self determinePrimaryDirection: aText at: bIndex.

	self determineAlignment: aText at: bIndex.
		
	tokens := self tokenize: aText from: bIndex to: eIndex.
	
	base := bIndex - 1.

	breaker := alignment = #justified ifTrue:[BidiJustifiedLineBreaker new stretch: 1.2; shrink:0.5; yourself] ifFalse:[BidiRaggedLineBreaker new].
	
	breaks := breaker width: width; break: tokens.

	lines := breaks collect:[:each | each buildLine: tokens base: base direction: direction ]. 
	
	height := lines inject:0 into:[:acc : each | acc + each height].
	
	^tokens last end! !

!BidiParagraph methodsFor: 'building' stamp: 'DF 5/27/2023 21:18:25'!
determineAlignment: aText at: i
	
	| code |
	
	i > aText size ifTrue:[^self].
	
	code := aText alignmentAt: i.
	
	code = BidiParagraph leftFlushCode ifTrue:[alignment := #left. ^self].
	code = BidiParagraph rightFlushCode ifTrue:[alignment := #right. ^self].
	code = BidiParagraph centeredCode ifTrue:[alignment := #center. ^self].	
	code = BidiParagraph justifiedCode ifTrue:[alignment := #justified. ^self].
	! !

!BidiParagraph methodsFor: 'building' stamp: 'DF 5/6/2023 16:58:28'!
determinePrimaryDirection: aText at: anIndex

	| d i | 
	
	i := anIndex.
	
	[i <= aText size and:[aText at: i :: writingDirection ~= #ltr] and:[aText at:i :: writingDirection ~= #rtl] ]
		whileTrue:[i := i + 1].

	d := i <= aText size ifTrue:[aText at: i :: writingDirection].
	
	direction := d = #rtl ifTrue:[-1] ifFalse:[d = #ltr ifTrue:[1] ifFalse:[direction] ].
! !

!BidiParagraph methodsFor: 'building' stamp: 'DF 5/6/2023 18:26:28'!
empty

	| line |
	
	lines removeAll.
	
	line := BidiLine emptyAt: 1.
	lines add: line	.
! !

!BidiParagraph methodsFor: 'building' stamp: 'DF 5/26/2023 21:05:22'!
tokenize: aText from: bIndex to: eIndex

	| tokens token |

	"A pargraph contains all characters until the first non line separator after
	two or more line separators."

	tokens := OrderedCollection new.
		
	token := BidiToken nextIn: aText from:bIndex to: eIndex direction: direction.
	
	[ token tag ~= #eot and: [ token tag ~= #nl ] ]
		whileTrue: [
			tokens add: token.
			token := BidiToken nextIn: aText after: token until: eIndex direction: direction.
			token tag = #nl 	
				ifTrue:[ 
					tokens add: token.
					token := BidiToken nextIn: aText after: token until: eIndex direction: direction ]		 ]	.
	
	" We have seen two line separators in a row. Add all the other lines separators. "	
	
	[ token tag = #nl ]
		whileTrue:[
			tokens add: token.
			token := BidiToken nextIn: aText after: token until: eIndex direction: direction ]	.	
		
	"( token tag = #eot )
		ifTrue:[	tokens add: token]."
	
	^tokens
	! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 5/27/2023 21:17:57'!
alignment: aSymbol
	"#justified #left #right or #center"
	alignment := aSymbol! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 4/4/2023 20:38:07'!
beginIndex
	^lines first beginIndex! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 6/3/2023 17:27:31'!
count
	^self terminalIndex - self beginIndex "+ 1" " we add 1 to account to the new line character that ends every paragraph but the last."! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 6/3/2023 17:23:27'!
endIndex

	| aLine |
	
	aLine := lines last.
	
	^aLine endIndex
	
	
! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 4/11/2023 16:47:36'!
height
	^height! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 6/3/2023 17:26:29'!
terminalIndex

	| aLine |
	
	aLine := lines last.

	^aLine newlineTerminated ifTrue:[aLine endIndex + 1] ifFalse:[aLine endIndex].
	
	
! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 4/4/2023 19:58:04'!
width: anInteger
	width := anInteger! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 4/8/2023 17:04:37'!
writingDirection
	^direction! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 4/12/2023 12:45:03'!
writingDirection: aDirection
	direction := aDirection! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 4/12/2023 10:26:21'!
above: aText at: anIndex

	"Answers the index of the code point directly above anIndex. That is,
	located at the same offset as anIndex but on the previous line. 
	
	Answers nil if anIndex is located on the first line. "
	
	| iy i aLine aLineAbove offset |
	
	iy := self lineAt: anIndex.
	
	i := iy at:1.
	
	i = 1 ifTrue:[^nil].
	
	aLine := lines at: i.
	
	aLineAbove := lines at:i - 1.
	
	offset := anIndex - aLine beginIndex.
	
	^ aLineAbove beginIndex + offset min: aLineAbove endIndex.
	! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 4/16/2023 11:51:16'!
aboveLastLine

	"Answers the index of the code point directly above anIndex. That is,
	located at the same offset as anIndex but on the previous line. 
	
	Answers nil if anIndex is located on the first line. "

	| aLineAbove |

	lines size = 1 ifTrue:[^nil].
	
	aLineAbove := 	lines at: lines size - 1.
		
	^ aLineAbove beginIndex
	! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 4/12/2023 10:26:28'!
below: aText at: anIndex

	"Answers the index of the code point directly below anIndex. That is,
	located at the same offset as anIndex but on the next line. 
	
	Answers nil if anIndex is located on the last line. "
	
	| iy i aLine aLineBelow offset |
	
	iy := self lineAt: anIndex.
	
	i := iy at:1.
	
	i = lines size ifTrue:[^nil].
	
	aLine := lines at: i.
	
	aLineBelow := lines at:i + 1.
	
	offset := anIndex - aLine beginIndex.
	
	^ aLineBelow beginIndex + offset min: aLineBelow endIndex.
	! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 4/28/2023 14:43:40'!
index: aText base: anInteger at: aPoint

	| y i |
	
	self assert: aPoint y >= 0.
	
	y := 0.
	
	i := 1.
	
	[i <= lines size and: [aPoint y > ((lines at:i :: height) + y) ] ] 
		whileTrue:[ y := y + (lines at:i :: height). i := i + 1].

	i <= lines size 	
		ifTrue:[^ lines at:i :: index: aText base: anInteger direction:direction width: width at: aPoint x alignment: alignment].
		
	lines isEmpty ifTrue:[^1].
	
	^ lines last endIndex.
	! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 6/3/2023 20:42:01'!
lastPoint: aText base: baseIndex 

	| x aLine |
	
	aLine := lines last.
	
	x := direction = 1 ifTrue:[aLine width] ifFalse:[width - aLine width].
	
	^aLine newlineTerminated 
		ifTrue:[
			0@(aLine height - aLine ascent) extent: 0@(aLine ascent + aLine descent)]
		ifFalse:[
			x@(0 - aLine ascent) extent: 0@(aLine ascent + aLine descent)].
	! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 6/3/2023 20:37:06'!
lineAt: offset

	| i y |

	i := 1.
	y := 0.
	
	[i <= lines size and:[lines at:i :: endIndex < offset]  ] 
		whileTrue:[y := y + (lines at:i :: height). i := i + 1. ].
	
	" When the offset is equal to endIndex we have three alternatives: 
	
	1. This is the last line in the last paragraph.
	2. This is the last line in the paragraph but the paragraph is not the last.
	3. This is the last line in the middle of the paragraph.
	
	1. If the line ends with a newline codepoint then we should answer a point that is 
	one line below the current line, 	otherwise we should answer the end of the current line.

	2. We answer this line because the next line will start a new paragraph and therefore 
	its beginIndex will be different.
		
	3. If the next line starts with the same offset we answer 	the next line, or if it doesn't, 
	we answer this line. "
	
	self assert: i <= (lines size + 1).

	i = lines size ifTrue:[^ { i.y }].
	
	lines at:i :: endIndex = offset and: [ lines at: i+1 :: beginIndex = offset ] :: 
		ifTrue:[^ {i+1 . y + (lines at: i + 1 :: height)} ].
	
	^{ i . y }! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 4/28/2023 14:41:41'!
point: aText base: baseIndex at: offset

	|i y iy x aLine |
	
	iy := self lineAt: offset.
	
	i := iy at:1. y := iy at:2.
	
	aLine := lines at:i.
	
	x := aLine xcoord: aText direction: direction base: baseIndex at: offset width: width alignment: alignment.
	
	^x@(y+aLine height - aLine ascent) extent: 0@(aLine ascent + aLine descent)! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 5/6/2023 12:47:35'!
rectangles: aText base: baseIndex from: bIndex to: eIndex

	| iy jy i j aLine rects y |
	
	iy := self lineAt:bIndex.	
	
	jy := self lineAt:eIndex.	
	
	i := iy at:1.
	
	j := jy at:1.
	
	aLine := lines at:i.
	y := iy at:2.
	
	i = j ifTrue:[ 		
		^aLine rectangles: aText base: baseIndex from: bIndex to: eIndex at: y direction: direction width: width alignment: alignment ].
	
	rects := OrderedCollection new.

	rects addAll:(
		aLine rectangles: aText base: baseIndex from: bIndex to: aLine endIndex at: y direction: direction width: width alignment: alignment).
	i := i + 1.
	
	[i < j] whileTrue:[
		y := y + aLine height.		
		aLine := lines at:i.
		rects addAll:(
			aLine rectangles: aText base: baseIndex from: aLine beginIndex to: aLine endIndex at: y direction: direction width: width alignment: alignment). 
		i := i + 1 ].

	self assert: i = j.
	
	y := y + aLine height.		
	aLine := lines at:i.	
	rects addAll:(
		aLine rectangles: aText base: baseIndex from: aLine beginIndex to: eIndex at: y direction: direction width: width alignment: alignment). 
	
	^rects! !

!BidiParagraph methodsFor: 'enumerating' stamp: 'DF 4/23/2023 21:35:16'!
first
	^self! !

!BidiParagraph methodsFor: 'enumerating' stamp: 'DF 4/23/2023 21:35:19'!
last
	^self! !

!BidiParagraph methodsFor: 'enumerating' stamp: 'DF 4/23/2023 21:34:40'!
pred
	"answer the previous paragraph in the paragraph tree, or nil if this is the first paragraph"
	
	|p |
	
	p := self.
	
	[p parent notNil and: [ p parent left == p] ] whileTrue:[p := p parent].
	
	p parent ifNil:[^nil].
	
	^p parent left last! !

!BidiParagraph methodsFor: 'enumerating' stamp: 'DF 4/23/2023 21:33:50'!
succ
	"answer the next paragraph in the paragraph tree, or nil if this is the last paragraph"
	
	|p |
	
	p := self.
	
	[p parent notNil and: [ p parent right == p] ] whileTrue:[p := p parent].
	
	p parent ifNil:[^nil].
	
	^p parent right first! !

!BidiParagraph methodsFor: 'tree interface' stamp: 'DF 4/23/2023 21:36:59'!
left
	^nil! !

!BidiParagraph methodsFor: 'tree interface' stamp: 'DF 4/22/2023 21:30:50'!
paragraphAt: anIndex

	^self! !

!BidiParagraph methodsFor: 'tree interface' stamp: 'DF 4/23/2023 21:38:25'!
parent
	^parent! !

!BidiParagraph methodsFor: 'tree interface' stamp: 'DF 4/22/2023 16:16:04'!
parent: aNode
	parent := aNode! !

!BidiParagraph methodsFor: 'tree interface' stamp: 'DF 4/23/2023 21:37:02'!
right
	^nil! !

!BidiParagraph methodsFor: 'as yet unclassified' stamp: 'DF 4/22/2023 22:25:15'!
delete
	
	" delete self from the tree and answer the tree's root "
	
	| sibling grandpa p q |
	
	parent ifNil:[^nil].
	
	sibling := parent left == self ifTrue:[parent right] ifFalse:[parent left].
	
	grandpa := parent parent.
	
	grandpa ifNil:[sibling parent: nil. ^sibling].
	
	sibling parent: grandpa.
	
	grandpa left == parent ifTrue:[grandpa left: sibling] ifFalse:[grandpa right: sibling].
	
	p := grandpa.
	
	[p isNil] 
		whileFalse:[
			p update.
			q := p.
			p := p parent ].
	
	^q! !

!BidiParagraph class methodsFor: 'instance creation' stamp: 'DF 5/6/2023 18:26:46'!
empty

	^self new empty; yourself.
! !

!BidiParagraph class methodsFor: 'as yet unclassified' stamp: 'DF 5/6/2023 13:02:55'!
centeredCode
	^2! !

!BidiParagraph class methodsFor: 'as yet unclassified' stamp: 'DF 5/6/2023 13:03:01'!
justifiedCode
	^3! !

!BidiParagraph class methodsFor: 'as yet unclassified' stamp: 'DF 5/6/2023 13:03:06'!
leftFlushCode
	^0! !

!BidiParagraph class methodsFor: 'as yet unclassified' stamp: 'DF 5/6/2023 13:03:14'!
rightFlushCode
	^1! !

!BidiParenComposer class methodsFor: 'as yet unclassified' stamp: 'DF 4/16/2023 18:22:31'!
compose: aUnicodeString

	| output |
	
	output := OrderedCollection new.
	
	aUnicodeString do:[:c |
		output add:  (c codePoint > 127 	ifTrue:[c] ifFalse:[ Paren at: c codePoint ]) 	].
	
	^UnicodeString newFrom: output
	! !

!BidiParenComposer class methodsFor: 'as yet unclassified' stamp: 'DF 4/16/2023 18:03:26'!
initialize

	"self initialize"
	
	"A short subset of Unicode's bidi-bracket table. 
	
	For the full table see https://www.unicode.org/Public/UCD/latest/ucd/BidiBrackets.txt"
	
	Paren := ByteArray new: 128.
	
	1 to:128 do:[:i | Paren at:i put:i ].
	
	Paren 
		at: 0x28 put: 0x29;
		at: 0x29 put: 0x28;
		at: 0x5B put: 0x5D;
		at: 0x5D put: 0x5B;
		at: 0x7B put: 0x7D;
		at: 0x7D put: 0x7B.
		! !

!BidiTextMetrics methodsFor: 'as yet unclassified' stamp: 'DF 5/16/2023 20:45:22'!
ascent
	^ascent! !

!BidiTextMetrics methodsFor: 'as yet unclassified' stamp: 'DF 5/16/2023 20:44:46'!
ascent: aNumber
	ascent := aNumber! !

!BidiTextMetrics methodsFor: 'as yet unclassified' stamp: 'DF 5/19/2023 15:09:37'!
descent
	^descent! !

!BidiTextMetrics methodsFor: 'as yet unclassified' stamp: 'DF 5/16/2023 20:45:05'!
descent: aNumber
	descent := aNumber! !

!BidiTextMetrics methodsFor: 'as yet unclassified' stamp: 'DF 5/17/2023 21:17:40'!
encompass: aTextMetrics

	width := width + aTextMetrics width.
	height := height max: aTextMetrics height.
	ascent := ascent max: aTextMetrics ascent.
	descent := descent max: aTextMetrics descent.
	! !

!BidiTextMetrics methodsFor: 'as yet unclassified' stamp: 'DF 5/16/2023 20:45:30'!
height
	^height! !

!BidiTextMetrics methodsFor: 'as yet unclassified' stamp: 'DF 5/16/2023 20:44:39'!
height: aNumber
	height := aNumber! !

!BidiTextMetrics methodsFor: 'as yet unclassified' stamp: 'DF 5/16/2023 20:59:27'!
metrics: aText from: begin to: end

	| b n font  s |
	
	ascent := 0.
	descent := 0.
	width := 0.
	height := 0.
	
	begin > aText size ifTrue:[^self].
	
	b := begin.
	
	[b < end] whileTrue:[
	
		n := end - b min: (aText runLengthFor: b).
	
		font := aText fontAt: b default: nil.
	
		height := height max: font lineSpacing.
		ascent := ascent max: font ascent.
		descent  := descent max: font descent. 	
		
		s := ArabicComposer compose: aText from: b to: b+n-1.
		
		width := width + (font widthOfString: s).
		
		b := b+n ].
	
! !

!BidiTextMetrics methodsFor: 'as yet unclassified' stamp: 'DF 5/16/2023 20:45:25'!
width
	^width! !

!BidiTextMetrics methodsFor: 'as yet unclassified' stamp: 'DF 5/16/2023 20:44:31'!
width: aNumber
	width := aNumber! !

!BidiTextMetrics class methodsFor: 'as yet unclassified' stamp: 'DF 5/16/2023 20:56:19'!
empty

	| aBidiTextMetrics aFont |
	
	aBidiTextMetrics := self new.

	aFont := FontFamily defaultFamilyAndPointSize.
	
	aBidiTextMetrics width:0; height: aFont lineSpacing; ascent: aFont ascent; descent: aFont descent.
	
	^ aBidiTextMetrics ! !

!BidiTextMetrics class methodsFor: 'as yet unclassified' stamp: 'DF 5/16/2023 20:50:47'!
of: aText from: begin to: end

	| aBidiTextMetrics |
	
	aBidiTextMetrics := self new.
	
	aBidiTextMetrics metrics: aText from: begin to: end.
	
	^ aBidiTextMetrics ! !

!BidiToken methodsFor: 'as yet unclassified' stamp: 'DF 5/19/2023 18:29:10'!
shrink: aString

	end := end - 1.
	
	metrics := BidiTextMetrics of: aString from: begin to: end! !

!BidiToken methodsFor: 'accessing' stamp: 'DF 4/15/2023 13:58:47'!
begin
	^begin! !

!BidiToken methodsFor: 'accessing' stamp: 'DF 4/15/2023 13:59:27'!
begin: anIndex
	begin := anIndex! !

!BidiToken methodsFor: 'accessing' stamp: 'DF 5/20/2023 12:56:50'!
direction
	^direction! !

!BidiToken methodsFor: 'accessing' stamp: 'DF 5/20/2023 12:57:50'!
direction: aSymbol
	direction := aSymbol! !

!BidiToken methodsFor: 'accessing' stamp: 'DF 4/15/2023 13:58:50'!
end
	^end! !

!BidiToken methodsFor: 'accessing' stamp: 'DF 4/15/2023 13:59:33'!
end: anIndex
	end := anIndex! !

!BidiToken methodsFor: 'accessing' stamp: 'DF 5/16/2023 20:51:20'!
metrics
	^metrics! !

!BidiToken methodsFor: 'accessing' stamp: 'DF 5/16/2023 20:51:32'!
metrics: aBidiTextMetrics
	metrics := aBidiTextMetrics ! !

!BidiToken methodsFor: 'accessing' stamp: 'DF 4/15/2023 13:58:44'!
tag
	^tag! !

!BidiToken methodsFor: 'accessing' stamp: 'DF 4/15/2023 13:59:19'!
tag: aSymbol
	tag := aSymbol! !

!BidiToken methodsFor: 'accessing' stamp: 'DF 5/20/2023 16:13:09'!
width
	^metrics width! !

!BidiToken methodsFor: 'testing' stamp: 'DF 5/20/2023 13:03:30'!
isCompatibleWithDirection: dir

	^self isIncompatibleWithDirection: dir :: not! !

!BidiToken methodsFor: 'testing' stamp: 'DF 5/20/2023 13:03:17'!
isIncompatibleWithDirection: dir

	^(direction = #rtl and:[dir = 1]) or:[direction =#ltr and:[dir = -1] ] or:[direction = #tltr and:[dir=-1] ]! !

!BidiToken methodsFor: 'testing' stamp: 'DF 5/21/2023 09:14:44'!
isSeparator

	^tag = #ws or:[tag = #nl]
	! !

!BidiToken class methodsFor: 'instance creation' stamp: 'DF 5/20/2023 12:58:46'!
nextContra: aString at: index direction: dir
 
	| i wd |
	
	i := index.
	
	i := i + 1. 

	wd := dir = -1 ifTrue:[#ltr] ifFalse:[#rtl].
	
	[i <= aString size and:[aString at:i :: writingDirection = wd] ] whileTrue:[i := i + 1].

	^BidiToken new tag: #contra ; direction: wd; begin: index ; end: i ; metrics: (BidiTextMetrics of: aString from: index to: i) yourself.
	! !

!BidiToken class methodsFor: 'instance creation' stamp: 'DF 5/6/2023 15:23:21'!
nextIn: aString after: aToken until: eIndex direction: dir
 
	^self nextIn: aString from: aToken end to: eIndex direction: dir
		
	! !

!BidiToken class methodsFor: 'instance creation' stamp: 'DF 5/20/2023 12:59:34'!
nextIn: aString from: bIndex to:eIndex direction: dir
 
	| c |
	
	self assert: eIndex <= (aString size + 1).

	bIndex >= eIndex ifTrue:[^BidiToken new tag:#eot ; direction: #neutral ; begin: bIndex ; end: bIndex ; metrics: BidiTextMetrics empty ; yourself ].

	c := aString at:bIndex.
	
	c isLineSeparator ifTrue:[^BidiToken new tag:#nl ; direction: #neutral ; begin:bIndex ; end: bIndex+1; metrics: (BidiTextMetrics of: aString from: bIndex to: bIndex+1); yourself].
	
	c isSeparator ifTrue:[^BidiToken new tag:#ws ; direction: #neutral; begin:bIndex ; end: bIndex+1; metrics: (BidiTextMetrics of: aString from: bIndex to: bIndex+1); yourself].
 
	c writingDirection = #neutral ifTrue:[^self nextNeutral: aString at: bIndex].
	
	c writingDirection = #tltr ifTrue:[^ self nextNumber: aString at: bIndex direction: dir].

	c writingDirection = #ltr and:[dir = 1] :: ifTrue:[^self nextWord: aString at: bIndex direction: dir].
	
	c writingDirection = #rtl and:[dir = -1] :: ifTrue:[^self nextWord: aString at: bIndex direction: dir].
	
	^self nextContra: aString at: bIndex direction: dir.
		
	! !

!BidiToken class methodsFor: 'instance creation' stamp: 'DF 5/20/2023 13:00:39'!
nextNeutral: aString at: index
 
	| i |
	
	i := index.
	
	i := i + 1. 

	[i <= aString size and:[aString at:i :: isSeparator not] and:[aString at:i :: isLineSeparator not] and:[aString at:i :: writingDirection = #neutral] ] whileTrue:[i := i + 1].

	^BidiToken new tag: #word ; direction: #neutral; begin: index ; end: i ; metrics: (BidiTextMetrics of: aString from: index to: i); yourself.
	! !

!BidiToken class methodsFor: 'instance creation' stamp: 'DF 5/20/2023 13:02:18'!
nextNumber: aString at: index direction: dir
 
	| i |
	
	i := index.
	
	i := i + 1. 

	[i <= aString size and:[aString at:i :: writingDirection = #tltr] ] whileTrue:[i := i + 1].

	^BidiToken new tag: (dir = 1 ifTrue:[#word] ifFalse:[#contra]) ; direction: #tltr; begin: index ; end: i ; metrics: (BidiTextMetrics of: aString from: index to: i); yourself.
	! !

!BidiToken class methodsFor: 'instance creation' stamp: 'DF 5/20/2023 13:02:30'!
nextWord: aString at: index direction: dir
 
	| i wd |
	
	i := index.
	
	i := i + 1. 

	wd := dir = 1 ifTrue:[#ltr] ifFalse:[#rtl].
	
	[i <= aString size and:[aString at:i :: writingDirection = wd] ] whileTrue:[i := i + 1].

	^BidiToken new tag: #word ; direction: wd; begin: index ; end: i ; metrics: (BidiTextMetrics of: aString from: index to: i); yourself.
	! !

!BidiZone methodsFor: 'building' stamp: 'DF 5/26/2023 20:59:44'!
build: tokens base: baseIndex from: bIndex to: e direction: dir ratio: stretch 

	| b |

	self assert: bIndex < e.
	
	metrics := BidiTextMetrics new width:0 ; height:0 ; ascent:0 ; descent: 0; yourself.
		
	b := bIndex.

	beginIndex := tokens at:b	 :: begin - baseIndex.
	endIndex := beginIndex.
		
	[b < e and:[ self proceed: tokens at: b direction: dir ] ] 
		whileTrue:[ 
			endIndex := tokens at: b :: end - baseIndex	.
			metrics encompass: (tokens at:b :: metrics). 
			b := b + 1 ].
	^b.! !

!BidiZone methodsFor: 'building' stamp: 'DF 5/19/2023 15:11:42'!
emptyAt: anIndex

	beginIndex := anIndex.
	endIndex := anIndex.
	
	metrics := BidiTextMetrics empty.
! !

!BidiZone methodsFor: 'building' stamp: 'DF 5/22/2023 17:40:43'!
proceed: tokens at: index direction: dir

	^self subclassResponsibility ! !

!BidiZone methodsFor: 'drawing' stamp: 'DF 6/5/2023 10:07:24'!
draw: aText from: baseIndex on: aCanvas at: aPoint direction: direction

	| x y b e j font color r s extent |
	
	extent := self extent.
	
	r := direction = 1 ifTrue:[aPoint - (0@extent y) extent: extent] ifFalse:[aPoint - extent extent: extent].
	
	x := aPoint x.

	y := aPoint y.
	
	aCanvas frameRectangle: r borderWidth:1 color: (Color fromHexString: '#ffb044').
	
	b := baseIndex + beginIndex.
	
	self assert: b <= aText size.
	
	[ b < (baseIndex + endIndex) ] whileTrue:[
				
		j := aText runLengthFor: b.
		
		self assert: j > 0.
		
		font := aText fontAt: b default: nil.
		color := aText colorAt: b :: ifNil:[Color black].
		e := b+j-1 min: baseIndex + endIndex - 1.
		
		s := ArabicComposer compose:aText asString from: b to: e.
		
		s := direction = -1 
			ifTrue:[BidiParenComposer compose:s] 
			ifFalse:[s].
			
		aCanvas drawString: s from: 1 to: s size atBaseline: x@y font: font color: color direction: direction.
		x := x + ((font widthOfString: s from: 1 to: s size) * direction).
		b := e+1.

		self assert: b <= (aText size +1).

		 ]! !

!BidiZone methodsFor: 'accessing' stamp: 'DF 5/19/2023 15:10:40'!
ascent
	^metrics ascent! !

!BidiZone methodsFor: 'accessing' stamp: 'DF 4/15/2023 14:36:48'!
beginIndex
	^beginIndex! !

!BidiZone methodsFor: 'accessing' stamp: 'DF 5/19/2023 15:10:46'!
descent
	^metrics descent! !

!BidiZone methodsFor: 'accessing' stamp: 'DF 4/15/2023 14:36:52'!
endIndex
	^endIndex! !

!BidiZone methodsFor: 'accessing' stamp: 'DF 5/19/2023 15:10:56'!
extent
	^metrics width @ metrics height ! !

!BidiZone methodsFor: 'accessing' stamp: 'DF 5/19/2023 15:11:04'!
height
	^metrics height! !

!BidiZone methodsFor: 'accessing' stamp: 'DF 5/19/2023 18:02:26'!
metrics
	^metrics! !

!BidiZone methodsFor: 'accessing' stamp: 'DF 5/19/2023 15:11:11'!
width
	^metrics width! !

!BidiZone methodsFor: 'translating' stamp: 'DF 4/17/2023 18:27:42'!
index: aText base: anIndex direction: direction width: width at: x
	
	" answer the index of the code point located at x coordinate x. "
	
	| beginx i font |
	
	beginx := width.
	
	i := beginIndex.
	
	[ i < endIndex and:[ beginx * direction < (x * direction) ] ] 
		whileTrue:[
			font := aText fontAt: anIndex + i default:nil.
			beginx := beginx + ((font widthOf: (aText at: anIndex + i)) * direction). 
			i := i + 1 ].
		
	^i + anIndex
		! !

!BidiZone methodsFor: 'translating' stamp: 'DF 5/19/2023 15:22:32'!
rectangles: aText base: baseIndex from: bIndex to: eIndex at: aPoint direction: direction 

	| b e ix jx p q |
	
	b := bIndex max: beginIndex.
	e := eIndex min: endIndex.
	
	b >= endIndex ifTrue:[^{}].
	e <= beginIndex ifTrue:[^{}].
	
	ix := self xcoord: aText direction: direction base: baseIndex at: b x: aPoint x.

	jx := self xcoord: aText direction: direction base: baseIndex at: e x: aPoint x.
		
	p := direction = 1 ifTrue:[ix] ifFalse:[jx].
	q := direction = 1 ifTrue:[jx] ifFalse:[ix].
		
	^{ p@(aPoint y + self height - metrics ascent) extent: (q-p)@(metrics ascent + metrics descent)	 }.
! !

!BidiZone methodsFor: 'translating' stamp: 'DF 5/19/2023 21:30:42'!
xcoord: aText direction: direction base: baseIndex at: index x: x

	" answer the x coordinate of the code point whose index is index. "	
	
	| m |
	
	m := BidiTextMetrics new metrics: aText from: baseIndex + beginIndex to: baseIndex + index.
	
	^ x + (m width * direction).
		! !

!BidiZone class methodsFor: 'instance creation' stamp: 'DF 4/15/2023 13:56:52'!
emptyAt: anIndex

	| aZone |
	
	aZone := BidiNativeZone new. 
	
	aZone emptyAt: anIndex.
	
	^aZone
! !

!BidiZone class methodsFor: 'instance creation' stamp: 'DF 5/24/2023 20:54:36'!
from: aToken direction: dir

	aToken tag :: = #eot ifTrue:[^BidiNativeZone new].

	aToken tag :: = #ws ifTrue:[^BidiSkipZone new].

	aToken tag :: = #nl ifTrue:[^BidiSkipZone new].
	
	aToken isCompatibleWithDirection: dir :: 
		ifTrue:[^BidiNativeZone new] ifFalse:[^BidiContraZone new].! !

!BidiContraZone methodsFor: 'building' stamp: 'DF 5/24/2023 20:52:51'!
proceed: tokens at: index direction: dir

	| i |
	
	" A contra zone stops at a neutral token only if the first non neutral token is 
	in the opposite (original) direction. "
	
	i := index.
	
	[ i <= tokens size and:[tokens at:i :: tag ~= #ws] and:[tokens at:i :: direction = #neutral] ] 
		whileTrue:[i := i + 1].

	i > tokens size ifTrue:[^false].
	
	tokens at:i :: tag = #nl ifTrue:[^false].

	tokens at:i :: tag = #ws ifTrue:[^false].
	
	^ tokens at:i :: isCompatibleWithDirection: dir*-1
	
	! !

!BidiContraZone methodsFor: 'drawing' stamp: 'DF 5/19/2023 15:24:19'!
draw: aText from: baseIndex on: aCanvas at: aPoint direction: direction

	^super draw: aText from: baseIndex on: aCanvas at: aPoint + (metrics width * direction@0) direction: direction * -1! !

!BidiContraZone methodsFor: 'translating' stamp: 'DF 5/19/2023 18:42:24'!
xcoord: aText direction: direction base: baseIndex at: index x: width

	| x |
	
	x := super xcoord: aText direction: direction * -1 base: baseIndex at: index x: width.
	
	^x + (direction * metrics width)! !

!BidiNativeZone methodsFor: 'building' stamp: 'DF 5/24/2023 20:53:02'!
proceed: tokens at: index direction: dir

	| aToken |
	
	aToken := tokens at:index.
	
	^ aToken tag ~= #nl and: [aToken tag ~= #ws] and: [ aToken tag ~= #contra ]! !

!BidiSkipZone methodsFor: 'as yet unclassified' stamp: 'DF 5/22/2023 18:57:37'!
build: tokens base: baseIndex from: bIndex to: e direction: dir ratio: stretch 

	| b |
	
	b := super build:tokens base: baseIndex from:bIndex to:e direction: dir ratio: stretch.
	
	metrics width: metrics width * (1 + stretch).
	
	^b! !

!BidiSkipZone methodsFor: 'as yet unclassified' stamp: 'DF 5/24/2023 21:05:55'!
proceed: tokens at: index direction: dir

	| tag |
	
	tag := tokens at:index :: tag.
	
	^ tag = #ws or:[tag = #nl].! !

!Edge methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 11:50:12'!
connect: aSourceVertex to: aTargetVertex

	aSourceVertex addOutgoingEdge: self.
	
	from := aSourceVertex.
	to := aTargetVertex.! !

!Edge methodsFor: 'as yet unclassified' stamp: 'DF 5/14/2023 23:18:06'!
from
	^from! !

!Edge methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 11:43:22'!
from: aVertex
	from := aVertex! !

!Edge methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 11:51:28'!
to
	^to! !

!Edge methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 11:43:28'!
to: aVertex
	to := aVertex! !

!Edge methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 11:51:20'!
weight
	^weight! !

!Edge methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 11:43:35'!
weight: aNumber
	weight := aNumber! !

!Graph methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 12:06:31'!
addVertex: aVertex

	vertices add: aVertex! !

!Graph methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 11:52:13'!
initialize

	vertices := OrderedCollection new.
! !

!Graph methodsFor: 'as yet unclassified' stamp: 'DF 5/30/2023 21:19:50'!
min: aSet fun: aBlock

	"Answer the element with the minimal result when evaluating aBlock on all the elements of the receiver."
	| key vertex |
	
	aSet emptyCheck.
	
	vertex := aSet anyOne.
	key :=  aBlock value: vertex.
	
	aSet do: [:each | | x | x := aBlock value: each. x < key ifTrue:[key := x. vertex := each] ].
	
	^ vertex! !

!Graph methodsFor: 'as yet unclassified' stamp: 'DF 5/30/2023 21:20:06'!
shortestPathFrom: originVertex to: destVertex weightFunction: aBlock

	| unvisited current |
	
	unvisited := Set new.
	
	unvisited addAll: vertices.
	
	vertices do:[:each | each distance: Float fmax. each prev:nil. ].
	
	originVertex distance:0.
	
	current := originVertex. 
	
	[unvisited notEmpty]
		whileTrue:[
			current := self min: unvisited fun: [:each | each distance].
			current adj do:[:each | | d v | 
				v := each to.
				unvisited includes: v :: ifTrue:[ 
					d := current distance + (aBlock value: each weight).
					d < v distance ifTrue:[v distance: d]. v prev: each  ] ].
			unvisited remove: current ].
			
! !

!Vertex methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 11:50:09'!
addOutgoingEdge: anEdge

	adj add: anEdge.! !

!Vertex methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 12:29:49'!
adj
	^adj! !

!Vertex methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 12:17:12'!
distance
	^distance! !

!Vertex methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 12:17:07'!
distance: aNumber
	distance := aNumber! !

!Vertex methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 11:43:56'!
initialize
	adj := OrderedCollection new.! !

!Vertex methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 11:51:11'!
key
	^key! !

!Vertex methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 11:51:08'!
key: anObject
	key := anObject! !

!Vertex methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 13:02:54'!
prev
	^prev! !

!Vertex methodsFor: 'as yet unclassified' stamp: 'DF 5/12/2023 13:03:01'!
prev: aVertex
	prev := aVertex! !

!UnicodeCodePoint methodsFor: '*BidiText' stamp: 'DF 4/16/2023 14:02:30'!
writingDirection

	0 <=  value and: value  <= 47 :: ifTrue:[^#neutral].
	48 <= value  and:  value <= 57 :: ifTrue:[^#tltr].
	58 <=  value and: value  <= 63 :: ifTrue:[^#neutral].
	123 <=  value and: value  <= 127 :: ifTrue:[^#neutral].
	value = 16xA0 :: ifTrue:[^#neutral]. "non breaking space"
	16x0590 <=  value and:  value <= 16x05FF :: ifTrue:[^#rtl]. "Hebrew"
	16xFB1D <=  value and:  value <= 16xFB40 :: ifTrue:[^#rtl]. "Hebrew"
	16x06F0 <=  value and:  value <= 16x06F9 :: ifTrue:[^#tltr]. "Eastern Arabic Numerals"
	16x0600 <=  value and:  value <= 16x06FF :: ifTrue:[^#rtl]. "Arabic"
	16x0750 <=  value and:  value <= 16x077F :: ifTrue:[^#rtl]. "Arabic Supplement"
	16x0870 <=  value and:  value <= 16x08FF :: ifTrue:[^#rtl]. "Arabic Extended-A,B"
	16xFB50 <=  value and:  value <= 16xFDFF :: ifTrue:[^#rtl]. "Arabic Presentation Forms-A"
	16xFE70 <=  value and:  value <= 16xFEFF :: ifTrue:[^#rtl]. "Arabic Presentation Forms-B"

	^#ltr! !

!UnicodeString methodsFor: '*BidiText' stamp: 'DF 4/4/2023 18:15:18'!
displayOnBitBltCanvasEngine: engine from: startIndex to: stopIndex at: p font: aTrueTypeFont color: color direction: direction

	| byteStartIndex byteStopIndex |
	byteStartIndex := self byteIndexAt: startIndex.
	byteStopIndex := (self byteIndexAt: stopIndex+1)-1.
	^engine
		displayUtf8: bytes
		fromByte: byteStartIndex
		toByte: byteStopIndex
		at: p
		trueTypeFont: aTrueTypeFont
		color: color
		direction: direction.! !

!BitBltCanvasEngine methodsFor: '*BidiText' stamp: 'DF 4/17/2023 09:30:36'!
basicDisplayUtf8: aByteArray fromByte: byteStartIndex toByte: byteStopIndex at: aPoint trueTypeFont: aTrueTypeFont direction: direction

	"Answer position to place next glyph"

	| fdestX glyph maxHeight byteIndex n ascent lineGap deltaXForBaseGlyph deltaXForDiacriticalMark |
	
	deltaXForBaseGlyph := 0.
	
	ascent := aTrueTypeFont ascent.		  "expensive"
	lineGap := aTrueTypeFont lineGap."expensive"
	destY := aPoint y.
	fdestX := aPoint x.
	maxHeight := 0.
	byteIndex := byteStartIndex.
	[  byteIndex <= byteStopIndex ] whileTrue: [
		n := Character utf8BytesAndCodePointAt: byteIndex in: aByteArray
			into: [ :byte1 :byte2 :byte3 :byte4 |
				glyph := aTrueTypeFont glyphAtUtf8Byte1: byte1 byte2: byte2 byte3: byte3 byte4: byte4 ] 
			into: nil.

		sourceForm := glyph form.
		height := sourceForm height.
		width := sourceForm width.
			
		direction = -1 ifTrue:[
			fdestX := fdestX - glyph advanceWidth.
			maxHeight := maxHeight max: height		].
		"Center diacriticals marks."
		glyph advanceWidth = 0.0
			ifFalse: [
				deltaXForBaseGlyph := glyph deltaXToCenter.
				deltaXForDiacriticalMark := 0.0 ]
			ifTrue: [ 
				deltaXForDiacriticalMark := glyph deltaXToCenter.
				deltaXForDiacriticalMark = 0 ifFalse: [ "Only for those who specify a delta to center."					
					deltaXForDiacriticalMark := deltaXForDiacriticalMark - (deltaXForBaseGlyph * direction) ].
				 ].
		destX := (fdestX + glyph leftOffset + deltaXForDiacriticalMark) roundedHAFZ.
		destY := aPoint y + ascent + lineGap-1 - glyph topOffset.
		aTrueTypeFont isSuperscript
			ifTrue: [destY := destY - (ascent*0.55)]
			ifFalse: [
				aTrueTypeFont isSubscript
					ifTrue: [destY := destY + (ascent*0.3)]].
		destY := destY roundedHAFZ.
		self copyBits.
		direction = 1 ifTrue:[
			fdestX := fdestX + glyph advanceWidth.
			maxHeight := maxHeight max: height		].
		byteIndex := byteIndex + n
	].
	^ fdestX ceiling@(destY+maxHeight)! !

!BitBltCanvasEngine methodsFor: '*BidiText' stamp: 'DF 4/4/2023 18:13:32'!
displayUtf8: aByteArray fromByte: byteStartIndex toByte: byteStopIndex at: aPoint trueTypeFont: aTrueTypeFont color: foregroundColor direction: direction
	"If required, do a second pass with new rule and colorMap.
	Answer position to place next glyph
	Answer nil if nothing was done
	"

	| answer prevRule secondPassMap sourceDepth destDepth |

	"Slight optimization when there's nothing to do."
	clipHeight = 0 ifTrue: [^nil].
	clipWidth = 0 ifTrue: [^nil].

	sourceForm := nil. "Set it for each glyph"
	sourceX := 0.
	sourceY := 0.
	height := nil. "Set it for each glyph as sourceForm height".
	self setRuleAndMapFor: 32 foregroundColor: (foregroundColor alpha: 1).

	"If combinationRule is rgbMul, we might need the special two-pass technique for component alpha blending.
	If not, do it simply"
	combinationRule = 37 "rgbMul" ifFalse: [
		^self basicDisplayUtf8: aByteArray fromByte: byteStartIndex toByte: byteStopIndex at: aPoint trueTypeFont: aTrueTypeFont direction: direction ].
	
	"We need to do a second pass. The colormap set is for use in the second pass."
	secondPassMap := colorMap.
	sourceDepth := aTrueTypeFont cachedFormDepth.
	destDepth := destForm depth.
	colorMap := sourceDepth ~= destDepth
		ifTrue: [ Color cachedColormapFrom: sourceDepth to: destDepth ].
	answer := self basicDisplayUtf8: aByteArray fromByte: byteStartIndex toByte: byteStopIndex at: aPoint trueTypeFont: aTrueTypeFont direction: direction.
	colorMap := secondPassMap.
	secondPassMap ifNotNil: [
		prevRule := combinationRule.
		combinationRule := 20. "rgbAdd"
		self basicDisplayUtf8: aByteArray fromByte: byteStartIndex toByte: byteStopIndex at: aPoint trueTypeFont: aTrueTypeFont direction: direction.
		combinationRule := prevRule ].
	^answer! !

!BitBltCanvas methodsFor: '*BidiText' stamp: 'DF 4/4/2023 18:16:12'!
drawString: aString from: firstIndex to: lastIndex atBaseline: aPoint font: font color: aColor direction: direction
	"Answer position to place next glyph
	Answer nil if nothing was done"

	| p1 |
	"Don't waste any time if NOP"
	lastIndex = 0 ifTrue: [
		^nil ].

	p1 := currentTransformation transform: aPoint roundedHAFZ.
	p1 := p1 + (0@(0 - (font ascent + font lineGap-1))).
	p1 := p1 roundedHAFZ.
	engine colorMap: nil.
	^aString asUnicodeString displayOnBitBltCanvasEngine: engine
		from: firstIndex
		to: lastIndex
		at: p1
		font: font
		color: aColor
		direction: direction! !
ArabicComposer initialize!
BidiParenComposer initialize!
