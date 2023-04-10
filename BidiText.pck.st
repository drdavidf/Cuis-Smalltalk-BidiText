'From Cuis 6.0 [latest update: #5722] on 10 April 2023 at 5:17:58 pm'!
'Description '!
!provides: 'BidiText' 1 30!
SystemOrganization addCategory: 'BidiText'!


!classDefinition: #BidiTextMorph category: 'BidiText'!
BoxedMorph subclass: #BidiTextMorph
	instanceVariableNames: 'text editor paragraph state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiTextMorph class' category: 'BidiText'!
BidiTextMorph class
	instanceVariableNames: ''!

!classDefinition: #BidiEditor category: 'BidiText'!
Object subclass: #BidiEditor
	instanceVariableNames: 'text point mark'
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

!classDefinition: #BidiParagraph category: 'BidiText'!
Object subclass: #BidiParagraph
	instanceVariableNames: 'direction lines width'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiText'!
!classDefinition: 'BidiParagraph class' category: 'BidiText'!
BidiParagraph class
	instanceVariableNames: ''!


!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 4/8/2023 16:26:30'!
copySelection

	| aText |

	editor mark = editor point ifTrue:[^self].
	
	aText := editor selection.
	
	Clipboard storeObject: aText.! !

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 4/8/2023 16:41:20'!
cut

	| aText |

	editor mark = editor point ifTrue:[^self].
	
	aText := editor selection.
	Clipboard storeObject: aText.
	
	editor backspace.
	paragraph rebuild: text.	
	
	self redrawNeeded.! !

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 4/8/2023 16:37:58'!
paste

	"Paste the text from the shared buffer over the current selection and 
	redisplay if necessary."

	editor replaceSelectionWith: Clipboard retrieveStringOrText.
	
	paragraph rebuild: text.
	
	self redrawNeeded.! !

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 4/8/2023 16:31:08'!
pasteRecent
	"Paste an item chose from RecentClippings."

	| clipping |
	(clipping := Clipboard chooseRecentClipping) ifNil: [^ self].
	self clipboardTextPut: clipping.
	^ self paste! !

!BidiTextMorph methodsFor: 'clipboard' stamp: 'DF 4/8/2023 16:38:03'!
pasteString

	editor replaceSelectionWith: Clipboard retrieveStringOrText asPlainString.
	
	paragraph rebuild: text.
	
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

!BidiTextMorph methodsFor: 'menus' stamp: 'DF 4/8/2023 15:58:39'!
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
	
	self addCutAndPasteMenuSectionTo: aMenu.
	aMenu addLine.
	
	^aMenu

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

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/10/2023 17:17:16'!
keyStroke: aKeyboardEvent

	| dir char |
	
	dir := paragraph writingDirection.
	
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
		p := paragraph above: text at: editor point.
		p ifNotNil: [ 
			editor movePointTo: p.
			aKeyboardEvent shiftPressed 
				ifFalse:[	editor moveMarkTo: editor point]. 
			self redrawNeeded ].
		^self ].

	aKeyboardEvent isArrowDown ifTrue:[ 		| p |
		p := paragraph below: text at: editor point.
		p ifNotNil: [ 
			editor movePointTo: p.
			aKeyboardEvent shiftPressed 
				ifFalse:[	editor moveMarkTo: editor point]. 
			self redrawNeeded ].
		 ^self ].
	
	aKeyboardEvent isBackspace ifTrue:[ 
		editor backspace.
		paragraph rebuild: text.
		self redrawNeeded. ^self ].

	aKeyboardEvent isDelete ifTrue:[ 
		editor delete.
		paragraph rebuild: text.
		self redrawNeeded. ^self ].

	aKeyboardEvent isReturnKey ifTrue:[ 
		editor insert: String lfString.
		paragraph rebuild: text.
		self redrawNeeded. ^self ].
	
	char := aKeyboardEvent keyCharacter.
	
	self addCodePoint: char.
			
	paragraph rebuild: text.
	self redrawNeeded.
	! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/6/2023 21:13:41'!
keyboardFocusChange: aBoolean

	"self halt."! !

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/7/2023 14:37:09'!
mouseButton1Down: aMouseButtonEvent localPosition: localEventPosition

	| i |
	
	i := paragraph index: text at: localEventPosition.
	
	editor movePointTo: i; moveMarkTo: i.
	
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

!BidiTextMorph methodsFor: 'events' stamp: 'DF 4/7/2023 14:37:13'!
mouseMove: aMouseMoveEvent localPosition: localEventPosition

	aMouseMoveEvent mouseButton1Pressed ifTrue:[
		editor moveMarkTo: (paragraph index: text at: localEventPosition)	. self redrawNeeded 	]! !

!BidiTextMorph methodsFor: 'drawing' stamp: 'DF 4/7/2023 14:36:52'!
drawCursorOn: aCanvas

	| aRect |
	
	aRect := paragraph point: text at: editor point.
		
	aCanvas line: aRect origin to: aRect corner width: 2 color: Color black.! !

!BidiTextMorph methodsFor: 'drawing' stamp: 'DF 4/7/2023 14:36:56'!
drawOn: aCanvas

	super drawOn: aCanvas.

	self drawSelectionOn: aCanvas.
	
	paragraph draw: text on: aCanvas. 
	
	self drawCursorOn: aCanvas.
! !

!BidiTextMorph methodsFor: 'drawing' stamp: 'DF 4/7/2023 14:37:00'!
drawSelectionOn: aCanvas

	| b e  rects |
	
	b := editor point min: editor mark.
	
	e := editor point max: editor mark.
	
	b = e ifTrue:[^self].
	
	rects := paragraph rectangles: text from: b  to: e.
	
	rects do:[:each | aCanvas fillRectangle: each color: Color lightBlue ].
! !

!BidiTextMorph methodsFor: 'drawing' stamp: 'DF 4/7/2023 14:37:04'!
extentChanged: oldExtent
	
	paragraph width: self morphWidth ; rebuild: text ! !

!BidiTextMorph methodsFor: 'initialization' stamp: 'DF 4/8/2023 17:34:38'!
initialize

	super initialize.
	
	text := '' asText.
	
	editor := BidiEditor new.
	
	editor text: text.
	
	paragraph := BidiParagraph new.
	
	paragraph width: 640.
	
	paragraph rebuild: text.
	
	state := #normal! !

!BidiTextMorph methodsFor: 'accessing' stamp: 'DF 4/7/2023 14:37:56'!
text: aText

	text := aText.
	
	editor text: aText.
	
	paragraph rebuild: aText.! !

!BidiTextMorph methodsFor: 'bidi typing' stamp: 'DF 4/10/2023 16:48:46'!
addCodePoint: aCodePoint

	self compatible: aCodePoint writingDirection with: paragraph writingDirection ::
		ifTrue:[	 | p |
			p := self advanceOverNeutrals: editor point.
			p <= text size and: [ self incompatible: (text at:p :: writingDirection) with: paragraph writingDirection ] :: 
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
			
			p <= text size and: [ self incompatible: (text at:p :: writingDirection) with: paragraph writingDirection ] :: 
				ifTrue: [ editor decrementPointMark 					]. 
			p <= text size and: [ text at:p :: writingDirection = #tltr ] :: 
				ifTrue:[ editor decrementPointMark 					]. 
			 ^self].

	" digits break the left-to-right right-to-left symmetry because they are always typed 
	left-to-right, even in right-to-left languages."
	
	aCodePoint writingDirection = #tltr and: [paragraph writingDirection = 1] :: 
		ifTrue:[
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

!BidiTextMorph methodsFor: 'bidi typing' stamp: 'DF 4/10/2023 16:31:58'!
advanceToNative: anIndex

	" advance from anIndex until you either get to a code point whose writing direction is 
	the same as the paragraph's writing direction, or to the end of the text"
	
	| native i |
	
	native := paragraph writingDirection = 1 ifTrue:[#ltr] ifFalse:[#rtl].
	
	i := anIndex.
	
	[i <= text size and:[text at:i :: writingDirection ~= native ] ] whileTrue:[i := i + 1].
	
	^i! !

!BidiTextMorph methodsFor: 'bidi typing' stamp: 'DF 4/10/2023 16:30:34'!
backToContra: anIndex

	" go back from anIndex until you either get to a code point whose writing direction is contra
	to the paragraph's writing direction, or to a digit, or you reach the beginning of text. "
	
	| contra i c |
	
	contra := paragraph writingDirection = 1 ifTrue:[#rtl] ifFalse:[#ltr].
	
	i := anIndex.
	
	i > 1 ifTrue:[c := text at:i -1 :: writingDirection].
	
	[i > 1 and:[c ~= contra ] and:[c ~= #tltr ] ] whileTrue:[
		i := i - 1.
		i > 1 ifTrue:[c := text at:i -1 :: writingDirection] ].
	
	^i! !

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

!BidiEditor methodsFor: 'initialization' stamp: 'DF 4/7/2023 14:48:26'!
initialize
	point := 1.
	mark := 1.! !

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

!BidiEditor methodsFor: 'as yet unclassified' stamp: 'DF 4/7/2023 18:51:13'!
backspace

	mark = point ifTrue:[self moveMarkTo: point - 1].
	self replaceSelectionWith: ''.
	self movePointTo: (point min: mark).
	self moveMarkTo: point.
! !

!BidiEditor methodsFor: 'as yet unclassified' stamp: 'DF 4/9/2023 18:16:12'!
decrementPointMark

	self movePointTo: point - 1;  moveMarkTo: point 		! !

!BidiEditor methodsFor: 'as yet unclassified' stamp: 'DF 4/9/2023 18:21:35'!
delete

	mark = point ifTrue:[self movePointTo: point + 1].
	self replaceSelectionWith: ''.
	
	self movePointTo: (point min: mark).
	self moveMarkTo: point.
! !

!BidiEditor methodsFor: 'as yet unclassified' stamp: 'DF 4/7/2023 18:52:44'!
insert: aCodePoint

	self replaceSelectionWith: aCodePoint asString.
	self movePointTo: point + 1.
	self moveMarkTo: point.
! !

!BidiEditor methodsFor: 'as yet unclassified' stamp: 'DF 4/7/2023 20:14:17'!
moveMarkTo: anInteger
	mark := anInteger min: text size + 1  :: max: 1! !

!BidiEditor methodsFor: 'as yet unclassified' stamp: 'DF 4/7/2023 20:14:13'!
movePointTo: anInteger
	
	point := anInteger min: text size + 1 :: max: 1! !

!BidiEditor methodsFor: 'as yet unclassified' stamp: 'DF 4/8/2023 15:23:10'!
paste

	"Paste the text from the shared buffer over the current selection and 
	redisplay if necessary."

	self replaceSelectionWith: Clipboard retrieveStringOrText ! !

!BidiEditor methodsFor: 'as yet unclassified' stamp: 'DF 4/7/2023 15:03:22'!
replaceSelectionWith: aText

	| b e |
	
	b := mark min: point.
	e := mark max: point.
	
	text replaceFrom: b to: e - 1 with: aText
	! !

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

!BidiLine methodsFor: 'building' stamp: 'DF 4/9/2023 23:03:52'!
rebuild: aText index: anInteger width: width
	
	| w h ex i m |

	beginIndex := anInteger.
	endIndex := anInteger.
	
	i := self advanceIn: aText from: endIndex.
	m := aText metricsFrom: endIndex to: i - 1.
	ex := m at:1.

	ascent := m at:2.
	descent := m at:3.
	h := ex y.
	w := 0.
		
	[w + ex x <= width and:[endIndex <= aText size] and: [ aText at:endIndex :: isLineSeparator not ] ] 
		whileTrue:[
			w := w + ex x.
			h := h max: ex y.			
			ascent := ascent max: (m at: 2).
			descent := descent max: (m at: 3).
			endIndex := i.
			i := self advanceIn: aText from: endIndex.
			m := aText metricsFrom: endIndex to: i - 1		.
			ex := m at:1	 	].
	
	extent := w@h.
	! !

!BidiLine methodsFor: 'drawing' stamp: 'DF 4/7/2023 12:22:32'!
draw: aText on: aCanvas at: y direction: direction width: width 

	| x b e j font color r |
	
	r := direction = 1 ifTrue:[0@(y - extent y) extent: extent] ifFalse:[width - extent x@(y - extent y) extent: extent].
	aCanvas frameRectangle: r borderWidth:1 color: Color blue.
	
	x := direction = 1 ifTrue:[0] ifFalse:[width].

	b := beginIndex.
	
	[ b < endIndex ] whileTrue:[
		
		j := aText runLengthFor: b.
		font := aText fontAt: b default: nil.
		color := aText colorAt: b :: ifNil:[Color black].
		e := b+j-1 min: endIndex - 1.
		aCanvas drawString: aText asString from: b to: e atBaseline: x@y font: font color: color direction: direction.
		x := x + ((font widthOfString: aText from: b to: e) * direction).
		b := e+1 ]! !

!BidiLine methodsFor: 'drawing' stamp: 'DF 4/10/2023 16:55:48'!
rectangle: aText from: bIndex to: eIndex at: y direction: direction width: width

	| ix jx p q |
	
	self assert: (beginIndex <= bIndex and: [bIndex <= endIndex]).
	self assert: (beginIndex <= eIndex and: [eIndex <= endIndex]).
	
	ix := self xcoord: aText direction: direction at: bIndex width: width.

	jx := self xcoord: aText direction: direction at: eIndex width: width.
		
	p := direction = 1 ifTrue:[ix] ifFalse:[jx].
	q := direction = 1 ifTrue:[jx] ifFalse:[ix].
		
	^p@(y + self height - ascent) extent: (q-p)@(ascent + descent)	.
! !

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

!BidiLine methodsFor: 'translating' stamp: 'DF 4/10/2023 16:55:48'!
xcoord: aText direction: direction at: index width: width

	" answer the x coordinate of the code point whose index is index. "	
	
	| ex m |
	
	m := aText metricsFrom: beginIndex to: index-1.
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

!BidiParagraph methodsFor: 'drawing' stamp: 'DF 4/9/2023 18:33:13'!
draw: aText on: aCanvas

	| y |
	
	lines isEmpty ifTrue:[^self].
	
	y := 0.
	
	lines do:[:each |
		y := y + each height.
		each draw: aText on: aCanvas at: y direction: direction width: width		].
	! !

!BidiParagraph methodsFor: 'drawing' stamp: 'DF 4/7/2023 16:19:34'!
rectangles: aText from: bIndex to: eIndex

	| iy jy i j aLine rects y |
	
	iy := self lineIndex: aText at:bIndex.	
	
	jy := self lineIndex: aText at:eIndex.	
	
	i := iy at:1.
	
	j := jy at:1.
	
	aLine := lines at:i.
	y := iy at:2.
	
	i = j ifTrue:[ 		
		^{ aLine rectangle: aText from: bIndex to: eIndex at: y direction: direction width: width} ].
	
	rects := OrderedCollection new.

	rects add:(
		aLine rectangle: aText from: bIndex to: aLine endIndex at: y direction: direction width: width).
	i := i + 1.
	
	[i < j] whileTrue:[
		y := y + aLine height.		
		aLine := lines at:i.
		rects add:(
			aLine rectangle: aText from: aLine beginIndex to: aLine endIndex at: y direction: direction width: width). 
		i := i + 1 ].

	self assert: i = j.
	
	y := y + aLine height.		
	aLine := lines at:i.	
	rects add:(
		aLine rectangle: aText from: aLine beginIndex to: eIndex at: y direction: direction width: width). 
	
	^rects! !

!BidiParagraph methodsFor: 'initialization' stamp: 'DF 4/4/2023 21:43:54'!
initialize

	direction := 1.
	
	lines := OrderedCollection new.! !

!BidiParagraph methodsFor: 'building' stamp: 'DF 4/9/2023 22:04:30'!
lineIndex: aText at: index

	|i y |
	
	i := 1.
	y := 0.
	
	[i <= lines size and:[lines at:i :: endIndex < index]  ] 
		whileTrue:[y := y + (lines at:i :: height). i := i + 1. ].
	
	^{ i . y }! !

!BidiParagraph methodsFor: 'building' stamp: 'DF 4/9/2023 23:07:16'!
rebuild: aText

	| d line i |
	
	lines removeAll.
	
	aText isEmpty 
		ifTrue:[ 
			lines add: (BidiLine emptyAt:1).
			^self].
	
	d := aText first asUnicodeCodePoint writingDirection.
	
	direction := d = #rtl ifTrue:[-1] ifFalse:[d = #ltr ifTrue:[1] ifFalse:[direction] ].
	
	i := 1.
	
	[ i <= aText size ]
		whileTrue: [
			line := BidiLine new rebuild: aText index: i width: width ; yourself.
			lines add: line.
			self assert: (i > aText size or: [aText at:i :: isLineSeparator] or: [line endIndex > i]).
			i := line endIndex.
			i <= aText size and: [aText at: i :: isLineSeparator ] :: 
				ifTrue:[ i := i + 1 ]			].
	
	aText last isLineSeparator ifTrue:[
		lines add: (BidiLine emptyAt: i) ].! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 4/4/2023 20:38:07'!
beginIndex
	^lines first beginIndex! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 4/4/2023 20:38:13'!
endIndex
	^lines last endIndex! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 4/4/2023 19:58:04'!
width: anInteger
	width := anInteger! !

!BidiParagraph methodsFor: 'accessing' stamp: 'DF 4/8/2023 17:04:37'!
writingDirection
	^direction! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 4/10/2023 17:12:02'!
above: aText at: anIndex

	"Answers the index of the code point directly above anIndex. That is,
	located at the same offset as anIndex but on the previous line. 
	
	Answers nil if anIndex is located on the first line. "
	
	| iy i aLine aLineAbove offset |
	
	iy := self lineIndex: aText at: anIndex.
	
	i := iy at:1.
	
	i = 1 ifTrue:[^nil].
	
	aLine := lines at: i.
	
	aLineAbove := lines at:i - 1.
	
	offset := anIndex - aLine beginIndex.
	
	^ aLineAbove beginIndex + offset min: aLineAbove endIndex.
	! !

!BidiParagraph methodsFor: 'translating' stamp: 'DF 4/10/2023 17:16:35'!
below: aText at: anIndex

	"Answers the index of the code point directly below anIndex. That is,
	located at the same offset as anIndex but on the next line. 
	
	Answers nil if anIndex is located on the last line. "
	
	| iy i aLine aLineBelow offset |
	
	iy := self lineIndex: aText at: anIndex.
	
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

!BidiParagraph methodsFor: 'translating' stamp: 'DF 4/10/2023 16:55:48'!
point: aText at: index

	|i y iy x aLine |
	
	iy := self lineIndex: aText at: index.
	
	i := iy at:1. y := iy at:2.
	
	i = (lines size + 1) "point is past the last character in the text"
		ifTrue:[i := i - 1. y := y - (lines at:i :: height)].
		
	aLine := lines at:i.
	
	x := aLine xcoord: aText direction: direction at: index width: width.
	
	^x@(y+aLine height - aLine ascent) extent: 0@(aLine ascent + aLine descent)! !

!UnicodeCodePoint methodsFor: '*BidiText' stamp: 'DF 4/7/2023 21:35:40'!
writingDirection

	32 <=  value and: value  <= 47 :: ifTrue:[^#neutral].
	48 <= value  and:  value <= 57 :: ifTrue:[^#tltr].
	58 <=  value and: value  <= 63 :: ifTrue:[^#neutral].
	16x05D0 <=  value and:  value <= 16x05EA :: ifTrue:[^#rtl]. "Hebrew"
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
