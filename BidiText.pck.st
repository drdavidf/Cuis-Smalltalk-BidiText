'From Cuis 6.0 [latest update: #5753] on 13 April 2023 at 3:49:46 pm'!
'Description BidiText provides support for displaying and editing bidirectional text.'!
!provides: 'BidiText' 1 49!
SystemOrganization addCategory: 'BidiText'!


!classDefinition: #BidiTextMorph category: 'BidiText'!
BoxedMorph subclass: #BidiTextMorph
	instanceVariableNames: 'text editor page'
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

!classDefinition: #BidiLine category: 'BidiText'!
Object subclass: #BidiLine
	instanceVariableNames: 'beginIndex endIndex extent ascent descent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiLine class' category: 'BidiText'!
BidiLine class
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
	instanceVariableNames: 'direction lines width height'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiParagraph class' category: 'BidiText'!
BidiParagraph class
	instanceVariableNames: ''!


!BidiLine commentStamp: '<historical>' prior: 0!
I represent a continous area of text that occupies a rectangle, representing a single line in a paragraph. 
My indices are relative to the beginning of my paragraph.!

!BidiPage commentStamp: '<historical>' prior: 0!
I represent a continous area of text composed of a collection of paragraphs.!

!BidiParagraph commentStamp: '<historical>' prior: 0!
I represent a continous area of text that has the same primary writing direction.!

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 4/8/2023 16:26:30'!
copySelection

	| aText |

	editor mark = editor point ifTrue:[^self].
	
	aText := editor selection.
	
	Clipboard storeObject: aText.! !

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 4/12/2023 09:48:51'!
cut

	| aText |

	editor mark = editor point ifTrue:[^self].
	
	aText := editor selection.
	Clipboard storeObject: aText.
	
	editor backspace.
	page rebuild: text.	
	
	self redrawNeeded.! !

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 4/12/2023 09:49:03'!
paste

	"Paste the text from the shared buffer over the current selection and 
	redisplay if necessary."

	editor paste: Clipboard retrieveStringOrText.
	
	page rebuild: text.
	
	self redrawNeeded.! !

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 4/8/2023 16:31:08'!
pasteRecent
	"Paste an item chose from RecentClippings."

	| clipping |
	(clipping := Clipboard chooseRecentClipping) ifNil: [^ self].
	self clipboardTextPut: clipping.
	^ self paste! !

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 4/12/2023 09:49:10'!
pasteString

	editor paste: Clipboard retrieveStringOrText asPlainString.
	
	page rebuild: text.
	
	self redrawNeeded.! !

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

!BidiTextMorph methodsFor: 'menus' stamp: 'DF 4/11/2023 15:04:38'!
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
	
	^aMenu

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

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/12/2023 09:45:47'!
keyStroke: aKeyboardEvent

	| dir char |
	
	dir := page writingDirectionAt: editor point.
	
	aKeyboardEvent isArrowLeft ifTrue:[
		editor movePointTo: editor point - dir. 
		aKeyboardEvent shiftPressed 
			ifFalse:[	editor moveMarkTo: editor point]. 
		self redrawNeeded. ^self ].
	
	aKeyboardEvent isArrowRight ifTrue:[
		editor movePointTo: editor point + dir. 
		aKeyboardEvent shiftPressed
			 ifFalse:[	editor moveMarkTo: editor point]. 
		self redrawNeeded. ^self ].

	aKeyboardEvent isArrowUp ifTrue:[ 		| p |
		p := page above: text at: editor point.
		p ifNotNil: [ 
			editor movePointTo: p.
			aKeyboardEvent shiftPressed 
				ifFalse:[	editor moveMarkTo: editor point]. 
			self redrawNeeded ].
		^self ].

	aKeyboardEvent isArrowDown ifTrue:[ 		| p |
		p := page below: text at: editor point.
		p ifNotNil: [ 
			editor movePointTo: p.
			aKeyboardEvent shiftPressed 
				ifFalse:[	editor moveMarkTo: editor point]. 
			self redrawNeeded ].
		 ^self ].
	
	aKeyboardEvent isBackspace ifTrue:[ 
		self backspace.
		page rebuild: text.
		self redrawNeeded. ^self ].

	aKeyboardEvent isDelete ifTrue:[ 
		editor delete.
		page rebuild: text.
		self redrawNeeded. ^self ].

	aKeyboardEvent isReturnKey ifTrue:[ 
		editor insert: String lfString.
		page rebuild: text.
		self redrawNeeded. ^self ].
	
	char := aKeyboardEvent keyCharacter.
	
	aKeyboardEvent controlKeyPressed and:[char = $c] :: ifTrue:[
		self copySelection.
		self redrawNeeded. ^self ].

	aKeyboardEvent controlKeyPressed and:[char = $v] :: ifTrue:[^self paste].

	aKeyboardEvent controlKeyPressed and:[char = $x] :: ifTrue:[	^	self cut].

	aKeyboardEvent controlKeyPressed and:[char = $z] :: ifTrue:[^self undo].

	aKeyboardEvent controlKeyPressed and:[char = $Z] :: ifTrue:[^self redo].

	self addCodePoint: char.
			
	page rebuild: text.
	self redrawNeeded.
	! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/6/2023 21:13:41'!
keyboardFocusChange: aBoolean

	"self halt."! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/12/2023 09:42:52'!
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

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/6/2023 21:13:13'!
mouseEnter: evt
	evt hand newKeyboardFocus: self! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/12/2023 09:43:50'!
mouseMove: aMouseMoveEvent localPosition: localEventPosition

	aMouseMoveEvent mouseButton1Pressed ifTrue:[
		editor moveMarkTo: (page index: text at: localEventPosition)	. self redrawNeeded 	]! !

!BidiTextMorph methodsFor: 'drawing' stamp: 'DF 4/11/2023 18:23:09'!
drawCursorOn: aCanvas

	| aRect |
	
	aRect := page point: text at: editor point.
		
	aCanvas line: aRect origin to: aRect corner width: 2 color: Color black.! !

!BidiTextMorph methodsFor: 'drawing' stamp: 'DF 4/12/2023 11:29:17'!
drawOn: aCanvas

	super drawOn: aCanvas.

	self drawSelectionOn: aCanvas.
	
	page draw: text on: aCanvas. 
	
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

!BidiTextMorph methodsFor: 'drawing' stamp: 'DF 4/11/2023 16:53:45'!
extentChanged: oldExtent
	
	page width: self morphWidth ; rebuild: text ! !

!BidiTextMorph methodsFor: 'initialization' stamp: 'DF 4/11/2023 16:52:38'!
initialize

	super initialize.
	
	text := '' asText.
	
	editor := BidiEditor new.
	
	editor text: text.
	
	page := BidiPage new.
	
	page width: 640.
	
	page rebuild: text.
	
	! !

!BidiTextMorph methodsFor: 'accessing' stamp: 'DF 4/13/2023 15:00:12'!
text: aText

	text := aText asUnicodeStringOrText asText.
	
	editor text: text.
	
	page rebuild: text.! !

!BidiTextMorph methodsFor: 'bidi typing' stamp: 'DF 4/12/2023 15:17:14'!
addCodePoint: aCodePoint

	| dir |
	
	dir := page writingDirectionAt: editor point.
	
	self compatible: aCodePoint writingDirection with: dir ::
		ifTrue:[	 | p |
			p := self advanceOverNeutrals: editor point.
			p <= text size and: [ self incompatible: (text at:p :: writingDirection) with: dir ] :: 
				ifTrue: [ 
					self retypeNeutralsAt: p.
					editor insert: aCodePoint. ^self ].
			p <= text size and: [ text at:p :: 		writingDirection = #tltr ] :: 
				ifTrue:[ 
					self retypeNeutralsAt: p.				
					editor insert: aCodePoint. ^self ].
			editor insert: aCodePoint. ^self].

	aCodePoint writingDirection = #neutral  
		ifTrue:[	 | p |
			editor insert: aCodePoint.		
			p := self advanceOverNeutrals: editor point.
			
			"When we type a neutral code point immediately after a contra code point, we face
			a non deterministic situation, because we do not know if the next code point will be
			another contra symbol in which case the neutral code point belongs to the contra
			fragment, or if we type a native symbol then the neutral code point should terminate
			the contra fragment, and move together with the native code point to the other end
			of the contra fragment. The solution that we have adopted here is to assume that the neutral 
			code symbols belong to the contra fragment until a native code symbol is typed. Then we 
			go back, collect the neutrals that precede the native code, and move them to their correct			position. "
			
			p <= text size and: [ self incompatible: (text at:p :: writingDirection) with: dir ] :: 
				ifTrue: [ editor decrementPointMark 					]. 
			p <= text size and: [ text at:p :: writingDirection = #tltr ] :: 
				ifTrue:[ editor decrementPointMark 					]. 
			 ^self].

	" digits break the left-to-right right-to-left symmetry because they are always typed 
	left-to-right, even in right-to-left languages."
	
	aCodePoint writingDirection = #tltr and: [dir = 1] :: 
		ifTrue:[
			editor insert: aCodePoint.		 
			^self ].

	" The code point is contra to the paragraph's writing direction,
	but if this is the first non line separator after two line separators
	then we should use it to determine the writing direction because
	once the page will be rebuilt it will be the first character in a new paragraph."
	
	text size = 0 or:[text size = 1 and:[text at:1 :: isLineSeparator] ] or:[editor point > 2 and:[text at: editor point - 1 :: isLineSeparator ] and: [text at: editor point - 2 :: isLineSeparator ] ] :: ifTrue:[
		editor insert: aCodePoint.				
		^self ].
	
	" at this point we know that we are typing a contra code point (a code point whose writing direction
	is contra to the paragraph's writing direction). "
		
	editor insert: aCodePoint.		
	editor decrementPointMark. 
! !

!BidiTextMorph methodsFor: 'bidi typing' stamp: 'DF 4/10/2023 16:31:02'!
advanceOverNeutrals: anIndex

	" advance from anIndex as long as you are at a neutral code point "
	
	| i |
	
	i := anIndex.
	
	[i <= text size and:[text at:i :: writingDirection = #neutral ] ] whileTrue:[i := i + 1].
	
	^i! !

!BidiTextMorph methodsFor: 'bidi typing' stamp: 'DF 4/12/2023 13:09:53'!
advanceToNative: anIndex

	" advance from anIndex until you either get to a code point whose writing direction is 
	the same as the paragraph's writing direction, or to the end of the text"
	
	| native i |
	
	native := page writingDirectionAt: editor point :: = 1 ifTrue:[#ltr] ifFalse:[#rtl].
	
	i := anIndex.
	
	[i <= text size and:[text at:i :: writingDirection ~= native ] ] whileTrue:[i := i + 1].
	
	^i! !

!BidiTextMorph methodsFor: 'bidi typing' stamp: 'DF 4/12/2023 13:10:02'!
backToContra: anIndex

	" go back from anIndex until you either get to a code point whose writing direction is contra
	to the paragraph's writing direction, or to a digit, or you reach the beginning of text. "
	
	| contra i c |
	
	contra := page writingDirectionAt: editor point :: = 1 ifTrue:[#rtl] ifFalse:[#ltr].
	
	i := anIndex.
	
	i > 1 ifTrue:[c := text at:i -1 :: writingDirection].
	
	[i > 1 and:[c ~= contra ] and:[c ~= #tltr ] ] whileTrue:[
		i := i - 1.
		i > 1 ifTrue:[c := text at:i -1 :: writingDirection] ].
	
	^i! !

!BidiTextMorph methodsFor: 'bidi typing' stamp: 'DF 4/12/2023 09:48:30'!
backspace

	| p dir |
	
	dir := page writingDirectionAt: editor point.
	
	p := self advanceOverNeutrals: editor point.
	
	p <= text size and: [ self incompatible: (text at:p :: writingDirection) with: dir ] :: 
		ifTrue:[editor delete. ^self].

	p <= text size and: [ text at:p :: writingDirection = #tltr and: [ dir = -1 ] ] :: 
		ifTrue:[editor delete. ^self].
		
	editor backspace.! !

!BidiTextMorph methodsFor: 'bidi typing' stamp: 'DF 4/9/2023 13:54:44'!
compatible: writingDirectionSymbol with: writingDirectionInteger

	^(writingDirectionSymbol = #rtl and:[writingDirectionInteger = -1]) or:[writingDirectionSymbol =#ltr and:[writingDirectionInteger = 1] ]! !

!BidiTextMorph methodsFor: 'bidi typing' stamp: 'DF 4/8/2023 17:24:09'!
incompatible: writingDirectionSymbol with: writingDirectionInteger

	^(writingDirectionSymbol = #rtl and:[writingDirectionInteger = 1]) or:[writingDirectionSymbol =#ltr and:[writingDirectionInteger = -1] ]! !

!BidiTextMorph methodsFor: 'bidi typing' stamp: 'DF 4/10/2023 16:33:36'!
retypeNeutralsAt: anIndex

	" remove all the neutral code points from the editor's point up to anIndex. 
	move to the furthest contra code point that is followed by a native code point
	and copy them there in reverse." 
	
	| p neutrals |
	
	p := anIndex.
	
	neutrals := text copyFrom: editor point to: p - 1.
	text replaceFrom: editor point to: p - 1 with: ''.
	p := self advanceToNative: editor point.
	p :=  self backToContra: p. 
	text replaceFrom: p to: p-1 with: neutrals reverse.
	editor movePointTo: p + neutrals size; moveMarkTo: editor point.! !

!BidiTextMorph methodsFor: 'history' stamp: 'DF 4/11/2023 15:05:50'!
offerUndoHistory! !

!BidiTextMorph methodsFor: 'history' stamp: 'DF 4/12/2023 09:49:14'!
redo

	editor redo.
	
	page rebuild: text.
	
	self redrawNeeded.! !

!BidiTextMorph methodsFor: 'history' stamp: 'DF 4/12/2023 09:49:18'!
undo

	editor undo.
	
	page rebuild: text.
	
	self redrawNeeded.! !

!ArabicComposer class methodsFor: 'as yet unclassified' stamp: 'DF 4/11/2023 11:54:01'!
compose: aUnicodeString

	| output b e |
	
	b := 1570.
	e := 1610.
	
	output := OrderedCollection new.
	
	1 to: 	aUnicodeString size do:[:i |
		
		b <= (aUnicodeString at:i) codePoint and:[(aUnicodeString at:i) codePoint <= e] :: 
			ifTrue:[
				"beginning of word"
				(i = 1 or: [aUnicodeString at:i -1 :: isSeparator ]) and: [i < aUnicodeString size] and: [ aUnicodeString at: i+1 :: isSeparator not ] :: ifTrue:[ | c | 
					c := Beginning at: (aUnicodeString at:i) codePoint - 1569.
					c ifNil:[output add: (aUnicodeString at:i) ] ifNotNil:[output add: (UnicodeCodePoint codePoint: c + 65165)] ].
				
				"middle of word"
				i > 1 and: [i < aUnicodeString size] and: [aUnicodeString at:i-1 :: isSeparator not ] and: [aUnicodeString at:i+1 :: isSeparator not] :: ifTrue:[ | c |
					
					c := Middle at: (aUnicodeString at:i) codePoint - 1569.
					c ifNil:[output add: (aUnicodeString at:i) ] ifNotNil:[output add: (UnicodeCodePoint codePoint: c + 65165)] ].
				
				"end of word" 
				i> 1 and:[ aUnicodeString at:i-1 :: isSeparator not] and: [i = aUnicodeString size or: [aUnicodeString at: i + 1 :: isSeparator] ] :: ifTrue:[
					| c |
					
					c := End at: (aUnicodeString at:i) codePoint - 1569.
					c ifNil:[output add: (aUnicodeString at:i) ] ifNotNil:[output add: (UnicodeCodePoint codePoint: c + 65165)]
					].
				
				"isolated"
				
				(i = 1 or: [aUnicodeString at: i - 1 :: isSeparator ]) and: [i = aUnicodeString size or: [aUnicodeString at: i+1 :: isSeparator ] ] :: ifTrue:[
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

!BidiEditor methodsFor: 'editing' stamp: 'DF 4/7/2023 18:51:13'!
backspace

	mark = point ifTrue:[self moveMarkTo: point - 1].
	self replaceSelectionWith: ''.
	self movePointTo: (point min: mark).
	self moveMarkTo: point.
! !

!BidiEditor methodsFor: 'editing' stamp: 'DF 4/11/2023 14:16:08'!
basicReplaceFrom: start to: stop with: replacement
	"As requested. Basic service used by Undo / Redo. Does not genertate undo."

	text replaceFrom: start to: stop with: replacement! !

!BidiEditor methodsFor: 'editing' stamp: 'DF 4/9/2023 18:21:35'!
delete

	mark = point ifTrue:[self movePointTo: point + 1].
	self replaceSelectionWith: ''.
	
	self movePointTo: (point min: mark).
	self moveMarkTo: point.
! !

!BidiEditor methodsFor: 'editing' stamp: 'DF 4/7/2023 18:52:44'!
insert: aCodePoint

	self replaceSelectionWith: aCodePoint asString.
	self movePointTo: point + 1.
	self moveMarkTo: point.
! !

!BidiEditor methodsFor: 'editing' stamp: 'DF 4/11/2023 14:55:19'!
paste: aText

	"Paste aText over the current selection."
	
	self replaceSelectionWith: aText.
	
	self movePointTo: point + aText size ; moveMarkTo: point. ! !

!BidiEditor methodsFor: 'editing' stamp: 'DF 4/11/2023 14:48:41'!
replaceSelectionWith: aText

	| b e aCommand |
	
	b := mark min: point.
	e := mark max: point.
	
	aCommand := text commandForReplaceFrom: b to: e-1  with: aText asUnicodeStringOrText.
	
	b = e and:[ history isEmpty not] and: [ history peekLast stopPosition = e ] :: 
		ifTrue:[
			history peekLast appendToNew: aText ]
		ifFalse:[
			history nextPut: aCommand; truncateAtPosition.	"To disable redo of previous commands, now invalidated." ].
	
	aCommand doOn: self.
	
	
	
	
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

!BidiLine methodsFor: 'accessing' stamp: 'DF 4/7/2023 12:30:08'!
ascent
	^ascent! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 4/9/2023 19:02:34'!
ascent: aNumber
	ascent := aNumber! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 4/4/2023 20:37:58'!
beginIndex
	^beginIndex! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 4/4/2023 17:47:23'!
beginIndex: anInteger
	beginIndex := anInteger! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 4/7/2023 12:30:13'!
descent
	^descent! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 4/9/2023 19:02:42'!
descent: aNumber
	descent := aNumber! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 4/4/2023 20:22:37'!
endIndex
	^endIndex! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 4/4/2023 17:47:32'!
endIndex: anInteger
	endIndex := anInteger! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 4/4/2023 17:43:25'!
extent: aPoint
	extent := aPoint! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 4/4/2023 21:34:46'!
height
	^extent y! !

!BidiLine methodsFor: 'accessing' stamp: 'DF 4/6/2023 16:07:04'!
width
	^extent x! !

!BidiLine methodsFor: 'building' stamp: 'DF 4/10/2023 16:50:29'!
advanceIn: aString from: index

	"If the character at index is a separator advance once, if not a separator, advance until a separator. "
	
	| i |
	
	index > aString size ifTrue:[^index].
	
	aString at:index :: isSeparator ifTrue:[^index + 1].
	
	i := index.
	
	i := i + 1.
	
	[i <= aString size and:[aString at:i :: isSeparator not] ] whileTrue:[i := i + 1].
	
	^i! !

!BidiLine methodsFor: 'building' stamp: 'DF 4/11/2023 17:41:08'!
rebuild: aText base: baseIndex index: anInteger width: width
	
	| w h ex i m |

	beginIndex := anInteger.
	endIndex := anInteger.
	
	i := self advanceIn: aText from: baseIndex + endIndex.
	m := aText metricsFrom: baseIndex + endIndex to: i - 1.
	ex := m at:1.

	ascent := m at:2.
	descent := m at:3.
	h := ex y.
	w := 0.
		
	[w + ex x <= width and:[baseIndex + endIndex <= aText size] and: [ aText at:baseIndex + endIndex :: isLineSeparator not ] ] 
		whileTrue:[
			w := w + ex x.
			h := h max: ex y.			
			ascent := ascent max: (m at: 2).
			descent := descent max: (m at: 3).
			endIndex := i - baseIndex.
			i := self advanceIn: aText from: baseIndex + endIndex.
			m := aText metricsFrom: baseIndex + endIndex to: i - 1		.
			ex := m at:1	 	].
	
	extent := w@h.
	! !

!BidiLine methodsFor: 'drawing' stamp: 'DF 4/11/2023 17:30:42'!
draw: aText from: baseIndex on: aCanvas at: y direction: direction width: width 

	| x b e j font color r |
	
	r := direction = 1 ifTrue:[0@(y - extent y) extent: extent] ifFalse:[width - extent x@(y - extent y) extent: extent].
	aCanvas frameRectangle: r borderWidth:1 color: Color blue.
	
	x := direction = 1 ifTrue:[0] ifFalse:[width].

	b := baseIndex + beginIndex.
	
	[ b < (baseIndex + endIndex) ] whileTrue:[
		
		j := aText runLengthFor: b.
		font := aText fontAt: b default: nil.
		color := aText colorAt: b :: ifNil:[Color black].
		e := b+j-1 min: baseIndex + endIndex - 1.
		aCanvas drawString: aText asString from: b to: e atBaseline: x@y font: font color: color direction: direction.
		x := x + ((font widthOfString: aText from: b to: e) * direction).
		b := e+1 ]! !

!BidiLine methodsFor: 'translating' stamp: 'DF 4/10/2023 16:54:36'!
index: aText direction: direction width: width at: x
	
	" answer the index of the code point located at x coordinate x. "
	
	| beginx i font |
	
	beginx := direction = 1 ifTrue:[ 0] ifFalse:[width].
	
	i := beginIndex.
	
	[ i < endIndex and:[ beginx * direction < (x * direction) ] ] 
		whileTrue:[
			font := aText fontAt: i default:nil.
			beginx := beginx + ((font widthOf: (aText at:i)) * direction). 
			i := i + 1 ].
		
	^i
		! !

!BidiLine methodsFor: 'translating' stamp: 'DF 4/12/2023 12:09:08'!
rectangle: aText base: baseIndex from: bIndex to: eIndex at: y direction: direction width: width

	| ix jx p q |
	
	self assert: (beginIndex <= bIndex and: [bIndex <= endIndex]).
	self assert: (beginIndex <= eIndex and: [eIndex <= endIndex]).
	
	ix := self xcoord: aText direction: direction base: baseIndex at: bIndex width: width.

	jx := self xcoord: aText direction: direction base: baseIndex at: eIndex width: width.
		
	p := direction = 1 ifTrue:[ix] ifFalse:[jx].
	q := direction = 1 ifTrue:[jx] ifFalse:[ix].
		
	^p@(y + self height - ascent) extent: (q-p)@(ascent + descent)	.
! !

!BidiLine methodsFor: 'translating' stamp: 'DF 4/11/2023 18:39:55'!
xcoord: aText direction: direction base: baseIndex at: index width: width

	" answer the x coordinate of the code point whose index is index. "	
	
	| ex m |
	
	m := aText metricsFrom: baseIndex + beginIndex to: baseIndex + index-1.
	ex := m at:1.
	direction = 1 ifTrue:[ ^ex x] ifFalse:[^width - ex x].	
		! !

!BidiLine class methodsFor: 'instance creation' stamp: 'DF 4/9/2023 19:02:52'!
empty

	| aFont aLine |
	
	aFont := FontFamily defaultFamilyAndPointSize.
	
	aLine := self new.
	 
	aLine beginIndex: 1 ; endIndex: 1; extent: 0@ aFont lineSpacing ; ascent: aFont ascent; descent: aFont descent.
	
	^aLine! !

!BidiLine class methodsFor: 'instance creation' stamp: 'DF 4/9/2023 19:19:41'!
emptyAt: anIndex

	| aFont aLine |
	
	aFont := FontFamily defaultFamilyAndPointSize.
	
	aLine := self new.
	 
	aLine beginIndex: anIndex ; endIndex: anIndex; extent: 0@ aFont lineSpacing ; ascent: aFont ascent; descent: aFont descent.
	
	^aLine! !

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

!BidiPage methodsFor: 'translating' stamp: 'DF 4/12/2023 15:39:35'!
above: aText at: anIndex

	| pc p c i |

	pc := self paragraphAt: anIndex.
	
	p := pc at:1.
	c := pc at:2.
	
	i := paragraphs at:p :: above: aText at: anIndex - c.
	
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

!BidiPage methodsFor: 'translating' stamp: 'DF 4/12/2023 10:22:09'!
index: aText at: aPoint

	| y i c |
	
	self assert: aPoint y >= 0.
	
	y := 0.
	
	c := 0.
	
	i := 1.
	
	[i <= paragraphs size and: [aPoint y > ((paragraphs at:i :: height) + y) ] ] 
		whileTrue:[ y := y + (paragraphs at:i :: height). c := c + (paragraphs at:i :: count) . i := i + 1].

	i <= paragraphs size 	
		ifTrue:[^ c + (paragraphs at:i :: index: aText at: aPoint - (0@y))].
		
	paragraphs isEmpty ifTrue:[^1].
	
	^ c + paragraphs last endIndex.
! !

!BidiPage methodsFor: 'translating' stamp: 'DF 4/12/2023 22:56:32'!
paragraphAt: charIndex

	| i c y |
	
	i := 1.
	
	c := 0.
	
	y := 0.
	
	[i <= paragraphs size and: [paragraphs at: i :: count + c <  charIndex] ]
		whileTrue:[c := c + (paragraphs at:i :: count). y := y + (paragraphs at:i :: height). i := i + 1.   ].
		
	^ { i . c . y }
	! !

!BidiPage methodsFor: 'translating' stamp: 'DF 4/13/2023 14:59:07'!
point: aText at: absoluteIndex

	| i c y icy |

	paragraphs isEmpty ifTrue:[^0@0 extent:0@0].
	
	icy := self paragraphAt: absoluteIndex.
	
	i := icy at:1.
	
	c := icy at:2.
	
	y := icy at:3.

	i = (paragraphs size + 1) "point is past the last character in the text"
		ifTrue:[ ^ (paragraphs last lastPoint: aText base: c) translatedBy: (0@y) ].

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

!BidiPage methodsFor: 'building' stamp: 'DF 4/12/2023 12:45:17'!
rebuild: aText

	| i aParagraph dir |
	
	dir := #ltr.
	
	paragraphs removeAll.
	
	i := 0.
	
	[ i < aText size ]
		whileTrue:[
			aParagraph := BidiParagraph new width: width; writingDirection: dir; rebuild: aText from: i; yourself.
			paragraphs add: aParagraph.
			dir := aParagraph writingDirection.
			i := i + aParagraph count ].
		
		! !

!BidiPage methodsFor: 'initialization' stamp: 'DF 4/11/2023 15:46:54'!
initialize

	paragraphs := OrderedCollection new.
	
	width := 640.! !

!BidiPage methodsFor: 'drawing' stamp: 'DF 4/11/2023 21:36:47'!
draw: aText on: aCanvas

	| i y |
	
	paragraphs isEmpty ifTrue:[^self].
	
	y := 0.
	i := 0.
	
	paragraphs do:[:each |
		each draw: aText from: i on: aCanvas at: y.
		y := y + each height.
		i := i + each count ].
! !

!BidiParagraph methodsFor: 'drawing' stamp: 'DF 4/11/2023 17:31:21'!
draw: aText from: baseIndex on: aCanvas at: y0

	| y |
	
	lines isEmpty ifTrue:[^self].
	
	y := y0.
	
	lines do:[:each |
		y := y + each height.
		each draw: aText from: baseIndex on: aCanvas at: y direction: direction width: width		].
	! !

!BidiParagraph methodsFor: 'initialization' stamp: 'DF 4/11/2023 16:47:43'!
initialize

	direction := 1.
	
	lines := OrderedCollection new.
	
	height := 0.! !

!BidiParagraph methodsFor: 'building' stamp: 'DF 4/12/2023 12:43:14'!
determinePrimaryDirection: aText at: anIndex

	| d i | 
	
	i := anIndex + 1.
	
	d := i <= aText size ifTrue:[aText at: i :: writingDirection].
	
	direction := d = #rtl ifTrue:[-1] ifFalse:[d = #ltr ifTrue:[1] ifFalse:[direction] ].
! !

!BidiParagraph methodsFor: 'building' stamp: 'DF 4/11/2023 21:50:14'!
rebuild: aText from: anIndex

	| line i |
	
	self determinePrimaryDirection: aText at: anIndex.
	
	lines removeAll.
	
	height := 0.
		
	" A pargraph contains all characters until the first non line separator after
	two or more line separators."
	
	i := anIndex + 1.
	
	[ i <= aText size and: [aText at:i :: isLineSeparator not ] ]
		whileTrue: [
			line := BidiLine new rebuild: aText base: anIndex index: i - anIndex width: width ; yourself.
			lines add: line.
			height := height + line height.
			self assert: (i > aText size or: [aText at:i :: isLineSeparator] or: [anIndex + line endIndex > i]).
			i := line endIndex + anIndex.
			i <= aText size and: [aText at: i :: isLineSeparator ] :: 
				ifTrue:[ i := i + 1 ]			].
	
	" We have seen two line separators in a row. Add all the other lines separators. "
	
	[ i <= aText size and: [aText at:i :: isLineSeparator ] ]
		whileTrue:[
			line := BidiLine emptyAt: i - anIndex.
			lines add: line.
			height := height + line height.
			i := i + 1 ].
		
	aText isEmpty 	ifTrue:[	
		line := BidiLine emptyAt: i - anIndex.
		lines add: line.
		height := height + line height		 ].
	! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 4/4/2023 20:38:07'!
beginIndex
	^lines first beginIndex! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 4/11/2023 22:35:03'!
count
	^self endIndex - self beginIndex + 1! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 4/4/2023 20:38:13'!
endIndex
	^lines last endIndex! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 4/11/2023 16:47:36'!
height
	^height! !

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

!BidiParagraph methodsFor: 'translating' stamp: 'DF 4/10/2023 16:26:00'!
index: aText at: aPoint

	| y i |
	
	self assert: aPoint y >= 0.
	
	y := 0.
	
	i := 1.
	
	[i <= lines size and: [aPoint y > ((lines at:i :: height) + y) ] ] 
		whileTrue:[ y := y + (lines at:i :: height). i := i + 1].

	i <= lines size 	
		ifTrue:[^ lines at:i :: index: aText direction:direction width: width at: aPoint x].
		
	lines isEmpty ifTrue:[^1].
	
	^ lines last endIndex.
	! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 4/12/2023 16:58:31'!
lastPoint: aText base: baseIndex 

	| x aLine |
	
	aLine := lines last.
	
	x := aLine xcoord: aText direction: direction base: baseIndex at: aLine endIndex width: width.
	
	^x@(0 - aLine ascent) extent: 0@(aLine ascent + aLine descent)! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 4/12/2023 22:47:22'!
lineAt: offset

	|i y |
	
	i := 1.
	y := 0.
	
	[i <= lines size and:[lines at:i :: endIndex < offset]  ] 
		whileTrue:[y := y + (lines at:i :: height). i := i + 1. ].
	
	" When the offset is equal to endIndex we have two alternatives: either
	the next line starts with the same offset, in which case we should answer
	the next line, or if it doesn't, we should chose this line. If this is the last
	line in the paragraph we always chose it because the next line will start a 
	new paragraph and therefore its beginIndex will be different."
	
	self assert: i <= (lines size + 1).
	
	i = lines size ifTrue:[^ { i.y }].
	
	lines at:i :: endIndex = offset and: [ lines at: i+1 :: beginIndex = offset ] :: 
		ifTrue:[^ {i+1 . y + (lines at: i + 1 :: height)} ].
	
	^{ i . y }! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 4/12/2023 16:10:03'!
point: aText base: baseIndex at: offset

	|i y iy x aLine |
	
	iy := self lineAt: offset.
	
	i := iy at:1. y := iy at:2.
	
	aLine := lines at:i.
	
	x := aLine xcoord: aText direction: direction base: baseIndex at: offset width: width.
	
	^x@(y+aLine height - aLine ascent) extent: 0@(aLine ascent + aLine descent)! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 4/12/2023 14:41:19'!
rectangles: aText base: baseIndex from: bIndex to: eIndex

	| iy jy i j aLine rects y |
	
	iy := self lineAt:bIndex.	
	
	jy := self lineAt:eIndex.	
	
	i := iy at:1.
	
	j := jy at:1.
	
	aLine := lines at:i.
	y := iy at:2.
	
	i = j ifTrue:[ 		
		^{ aLine rectangle: aText base: baseIndex from: bIndex to: eIndex at: y direction: direction width: width} ].
	
	rects := OrderedCollection new.

	rects add:(
		aLine rectangle: aText base: baseIndex from: bIndex to: aLine endIndex at: y direction: direction width: width).
	i := i + 1.
	
	[i < j] whileTrue:[
		y := y + aLine height.		
		aLine := lines at:i.
		rects add:(
			aLine rectangle: aText base: baseIndex from: aLine beginIndex to: aLine endIndex at: y direction: direction width: width). 
		i := i + 1 ].

	self assert: i = j.
	
	y := y + aLine height.		
	aLine := lines at:i.	
	rects add:(
		aLine rectangle: aText base: baseIndex from: aLine beginIndex to: eIndex at: y direction: direction width: width). 
	
	^rects! !

!UnicodeCodePoint methodsFor: '*BidiText' stamp: 'DF 4/11/2023 11:50:25'!
writingDirection

	32 <=  value and: value  <= 47 :: ifTrue:[^#neutral].
	48 <= value  and:  value <= 57 :: ifTrue:[^#tltr].
	58 <=  value and: value  <= 63 :: ifTrue:[^#neutral].
	16x05D0 <=  value and:  value <= 16x05EA :: ifTrue:[^#rtl]. "Hebrew"
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

!Text methodsFor: '*BidiText' stamp: 'DF 4/7/2023 12:32:15'!
metricsFrom: begin to: end

	| b n font w h a d |
	
	begin > self size ifTrue:[^{ 0@0 . 0 . 0 } ].
	
	w := 0.
	h := 0.
	a := 0. "ascent"
	d := 0. "descent"
	b := begin.
	
	[b <= end] whileTrue:[
	
		n := end - b + 1 min: (self runLengthFor: b).
	
		font := self fontAt: b default: nil.
	
		h := h max: font lineSpacing.
		a := a max: font ascent.
		d := d max: font descent. 	
		w := w + (font widthOfString: string from: b to: b+n-1).
		
		b := b+n ].
	
	^{ w@h . a . d }! !

!Text class methodsFor: '*BidiText' stamp: 'DF 4/7/2023 12:43:38'!
testExtentFrom

	"self testExtentFrom"
	
	| aText actual expected m |
	
	aText := 'Hello' asText.
	
	m := aText metricsFrom:1 to:aText size.
	actual := m at:1.
	expected := (aText fontAt: 1 default:nil) widthOfString: aText.
	
	self assert: actual x = expected.
	
	 m := aText metricsFrom:3 to:aText size.
	actual := m at:1.
	expected := (aText fontAt: 3 default:nil) widthOfString: aText from: 3 to: aText size.
	
	self assert: actual x = expected.! !

!BitBltCanvasEngine methodsFor: '*BidiText' stamp: 'DF 4/4/2023 18:37:34'!
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
					deltaXForDiacriticalMark := deltaXForDiacriticalMark - deltaXForBaseGlyph ].
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
