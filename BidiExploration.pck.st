'From Cuis 6.0 [latest update: #5722] on 10 April 2023 at 9:24:16 pm'!
'Description '!
!provides: 'BidiExploration' 1 1!
SystemOrganization addCategory: 'BidiExploration'!


!classDefinition: #BidiTextEditor category: 'BidiExploration'!
TextEditor subclass: #BidiTextEditor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiExploration'!
!classDefinition: 'BidiTextEditor class' category: 'BidiExploration'!
BidiTextEditor class
	instanceVariableNames: ''!

!classDefinition: #BidiCharacterBlockScanner category: 'BidiExploration'!
CharacterBlockScanner subclass: #BidiCharacterBlockScanner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiExploration'!
!classDefinition: 'BidiCharacterBlockScanner class' category: 'BidiExploration'!
BidiCharacterBlockScanner class
	instanceVariableNames: ''!

!classDefinition: #RtLCharacterBlockScanner category: 'BidiExploration'!
CharacterBlockScanner subclass: #RtLCharacterBlockScanner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiExploration'!
!classDefinition: 'RtLCharacterBlockScanner class' category: 'BidiExploration'!
RtLCharacterBlockScanner class
	instanceVariableNames: ''!

!classDefinition: #BidiMorphicScanner category: 'BidiExploration'!
MorphicScanner subclass: #BidiMorphicScanner
	instanceVariableNames: 'bidiParser'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiExploration'!
!classDefinition: 'BidiMorphicScanner class' category: 'BidiExploration'!
BidiMorphicScanner class
	instanceVariableNames: ''!

!classDefinition: #BidiInnerTextMorph category: 'BidiExploration'!
InnerTextMorph subclass: #BidiInnerTextMorph
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiExploration'!
!classDefinition: 'BidiInnerTextMorph class' category: 'BidiExploration'!
BidiInnerTextMorph class
	instanceVariableNames: ''!

!classDefinition: #BidiTextModelMorph category: 'BidiExploration'!
TextModelMorph subclass: #BidiTextModelMorph
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiExploration'!
!classDefinition: 'BidiTextModelMorph class' category: 'BidiExploration'!
BidiTextModelMorph class
	instanceVariableNames: ''!

!classDefinition: #BidiTextComposition category: 'BidiExploration'!
TextComposition subclass: #BidiTextComposition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiExploration'!
!classDefinition: 'BidiTextComposition class' category: 'BidiExploration'!
BidiTextComposition class
	instanceVariableNames: ''!

!classDefinition: #ArabicComposer category: 'BidiExploration'!
Object subclass: #ArabicComposer
	instanceVariableNames: ''
	classVariableNames: 'Beginning End Isolated Middle'
	poolDictionaries: ''
	category: 'BidiExploration'!
!classDefinition: 'ArabicComposer class' category: 'BidiExploration'!
ArabicComposer class
	instanceVariableNames: ''!

!classDefinition: #BidiPreprocessor category: 'BidiExploration'!
Object subclass: #BidiPreprocessor
	instanceVariableNames: 'input index state tokens stack buffer indices output permuted'
	classVariableNames: 'LRI PDI RLI'
	poolDictionaries: ''
	category: 'BidiExploration'!
!classDefinition: 'BidiPreprocessor class' category: 'BidiExploration'!
BidiPreprocessor class
	instanceVariableNames: ''!

!classDefinition: #BidiTextModel category: 'BidiExploration'!
Object subclass: #BidiTextModel
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'BidiExploration'!
!classDefinition: 'BidiTextModel class' category: 'BidiExploration'!
BidiTextModel class
	instanceVariableNames: ''!


!BidiTextEditor methodsFor: 'as yet unclassified' stamp: 'DF 4/1/2023 20:17:04'!
normalCharacter: aKeyboardEvent 
	"A nonspecial character is to be added to the stream of characters."

	| character i replacement |
	character := aKeyboardEvent keyCharacter.
	"Linux VMs don't automatically replace combining marks + space with ASCII,
	as Windows and Mac VMs do. It seems it is an app responsibility to do that in Linux."
	character isDiacriticalMark ifTrue: [
		i := self pointIndex-1.
		(i > 0 and: [ (self privateCurrentString at: i) = $  ]) ifTrue: [
			replacement := character caseOf: {
				[ `UnicodeCodePoint codePoint: 16r300` ] -> [ '`' ].
				[ `UnicodeCodePoint codePoint: 16r301` ] -> [ '''' ].
				[ `UnicodeCodePoint codePoint: 16r302` ] -> [ '^' ].
				[ `UnicodeCodePoint codePoint: 16r303` ] -> [ '~' ].
				[ `UnicodeCodePoint codePoint: 16r308` ] -> [ '"' ].
			} otherwise: [].
			replacement notNil ifTrue: [
				self selectFrom: i to: i; replaceSelectionWith: replacement.
				^ false ]
			]
		].
	self addString: (UnicodeString with: character).
	^false! !

!BidiCharacterBlockScanner methodsFor: 'as yet unclassified' stamp: 'DF 4/2/2023 12:26:39'!
characterBlockAtPoint: aPoint index: index in: textLine
	"This method is the Morphic characterBlock finder."
	| runLength lineStop stopCondition string parser permuted |
	line := textLine.
	rightMargin := line rightMargin.
	lastIndex := line first.
	tabCount := 0.
	self setFont.
	self setStopConditions.
	characterIndex := index.  "nil means scanning for point"
	characterPoint := aPoint.
	(characterPoint isNil or: [ characterPoint y > line bottom ])
		ifTrue: [ characterPoint := line bottomRight ].
	(text isEmpty or: [( characterPoint y < line top or: [ characterPoint x < line left ])
				or: [ characterIndex notNil and: [ characterIndex < line first ]]])
		ifTrue:	[^ CharacterBlock
					stringIndex: line first
					text: text
					topLeft: line leftMargin@line top
					extent: 0 @ line lineHeight
					textLine: line].
	 destX := leftMargin := line leftMarginForAlignment: alignment.
	destY := line top.
	runLength := text runLengthFor: line first.
	lineStop := characterIndex	"scanning for index"
		ifNil: [ line last ].			"scanning for point"
	runStopIndex := lastIndex + (runLength - 1) min: lineStop.
	lastCharacterWidth := 0.
	spaceCount := 0.

	string := text string asUnicodeString.
	
	parser := BidiPreprocessor new.
	
	parser process: string.

	permuted := parser permuted.

	self placeEmbeddedObject.
	[
		stopCondition := self scanCharactersFrom: lastIndex to: runStopIndex
			in: string rightX: characterPoint x
			stopConditions: stopConditions.
		"see setStopConditions for stopping conditions for character block operations."
		lastCharacterWidth := specialWidth ifNil: [ font widthOf: (text at: lastIndex) ].
		(self perform: stopCondition) ifTrue: [
			^characterIndex
				ifNil: [	"Result for characterBlockAtPoint: "
					CharacterBlock
						stringIndex: (lastIndex <= permuted size ifTrue:[permuted at:lastIndex] ifFalse:[lastIndex])
						text: text
						topLeft: characterPoint x@line top
						extent: lastCharacterWidth @ line lineHeight
						textLine: line ]
				ifNotNil: [	"Result for characterBlockForIndex: "
					CharacterBlock
						stringIndex: (characterIndex <= permuted size ifTrue:[permuted at:characterIndex] ifFalse:[characterIndex])
						text: text
						topLeft: characterPoint x@line top
						extent: lastCharacterWidth @ line lineHeight
						textLine: line ]]
		] repeat! !

!RtLCharacterBlockScanner methodsFor: 'as yet unclassified' stamp: 'DF 4/3/2023 15:46:56'!
characterBlockAtPoint: aPoint index: index in: textLine
	"This method is the Morphic characterBlock finder."
	| runLength lineStop stopCondition string |
	line := textLine.
	rightMargin := line rightMargin.
	lastIndex := line first.
	tabCount := 0.
	self setFont.
	self setStopConditions.
	characterIndex := index.  "nil means scanning for point"
	characterPoint := aPoint.
	(characterPoint isNil or: [ characterPoint y > line bottom ])
		ifTrue: [ characterPoint := line bottomRight ].
	(text isEmpty or: [( characterPoint y < line top or: [ characterPoint x < line left ])
				or: [ characterIndex notNil and: [ characterIndex < line first ]]])
		ifTrue:	[^ CharacterBlock
					stringIndex: line first
					text: text
					topLeft: line rightMargin@line top
					extent: 0 @ line lineHeight
					textLine: line].
	 destX := leftMargin := line leftMarginForAlignment: alignment.
	destY := line top.
	runLength := text runLengthFor: line first.
	lineStop := characterIndex	"scanning for index"
		ifNil: [ line last ].			"scanning for point"
	runStopIndex := lastIndex + (runLength - 1) min: lineStop.
	lastCharacterWidth := 0.
	spaceCount := 0.
	string := text string asUnicodeString.

	self placeEmbeddedObject.
	[
		stopCondition := self scanCharactersFrom: lastIndex to: runStopIndex
			in: string rightX: characterPoint x
			stopConditions: stopConditions.
		"see setStopConditions for stopping conditions for character block operations."
		lastCharacterWidth := specialWidth ifNil: [ font widthOf: (text at: lastIndex) ].
		(self perform: stopCondition) ifTrue: [
			^characterIndex
				ifNil: [	"Result for characterBlockAtPoint: "
					CharacterBlock
						stringIndex: lastIndex
						text: text
						topLeft: line width - characterPoint x@line top
						extent: lastCharacterWidth @ line lineHeight
						textLine: line ]
				ifNotNil: [	"Result for characterBlockForIndex: "
					CharacterBlock
						stringIndex: characterIndex
						text: text
						topLeft: line width - characterPoint x@line top
						extent: lastCharacterWidth @ line lineHeight
						textLine: line ]]
		] repeat! !

!BidiMorphicScanner methodsFor: 'as yet unclassified' stamp: 'DF 4/2/2023 20:14:58'!
displayLine: textLine textTopLeft: textTopLeft leftInRun: leftInRun
	"The call on the primitive (scanCharactersFrom:to:in:rightX:) will be interrupted according to an array of stop conditions passed to the scanner at which time the code to handle the stop condition is run and the call on the primitive continued until a stop condition returns true (which means the line has terminated).  leftInRun is the # of characters left to scan in the current run; when 0, it is time to call setStopConditions."

	"textTopLeft is relative to the morph currently being drawn"
	| stopCondition nowLeftInRun startIndex string lastPos x1 s |

	topLeft := textTopLeft.
	line := textLine.
	lineY := line top + textTopLeft y.
	rightMargin := line rightMargin + textTopLeft x.
	lastIndex := line first.
	tabCount := 0.
	leftInRun <= 0 ifTrue: [
		self setFont.
		self setStopConditions ].
	leftMargin := (line leftMarginForAlignment: alignment) + textTopLeft x.
	destX := leftMargin.
	destY := lineY + line baseline - font ascent.

	textLine isEmptyLine ifTrue: [
		textLine paragraphStyle ifNotNil: [ :ps |
			ps = paragraphStyle ifFalse: [
				foregroundColor := defaultColor.
				self setActualFont: ps font.
				ps color ifNotNil: [ :color | self textColor: color ].
				alignment := ps alignment.
				paragraphStyle := ps.
				spaceWidth := font widthOf: Character space.
				self setStopConditions.
				text ifNotNil: [ destY := lineY + line baseline - font ascent ]]].
		self displayBulletIfAppropriateFor: textLine textLeft: textTopLeft x.
		^leftInRun ].

	self displayBulletIfAppropriateFor: textLine textLeft: textTopLeft x.

	leftInRun <= 0
		ifTrue: [nowLeftInRun := text runLengthFor: lastIndex]
		ifFalse: [nowLeftInRun := leftInRun].
	runStopIndex := lastIndex + (nowLeftInRun - 1) min: line last.
	spaceCount := 0.
	string := text string asUnicodeString.
	self placeEmbeddedObject.
	[
		startIndex := lastIndex.
		lastPos := destX@destY.
		stopCondition := self
			scanCharactersFrom: lastIndex to: runStopIndex
			in: string rightX: rightMargin stopConditions: stopConditions.
		backgroundColor ifNotNil: [
			x1 := destX.
			((Preferences at: #backgroundColorFillsAllBackground) and: [startIndex > line last]) ifTrue: [
				x1 := rightMargin ].
			canvas
				fillRectangle: (lastPos corner: x1 @ (line bottom + textTopLeft y))
				color: backgroundColor.
			((Preferences at: #backgroundColorFillsAllBackground) and: [stopCondition = #tab]) ifTrue: [
				canvas
					fillRectangle: (destX @ lastPos y corner: self tabDestX @ (line bottom + textTopLeft y))
					color: backgroundColor ]].
		lastIndex >= startIndex ifTrue: [
			s :=  string copyFrom:startIndex to: lastIndex.			
			
			canvas    
				drawString: s reverse
				from: 1
				to: s size
				at: rightMargin @destY - ((font widthOfString: s) @ 0)
				font: font 
				color: foregroundColor ].
		"see setStopConditions for stopping conditions for displaying."
		(self perform: stopCondition) ifTrue: [
			"Number of characters remaining in the current run"
			^ runStopIndex - lastIndex ]
	] repeat! !

!BidiMorphicScanner methodsFor: 'as yet unclassified' stamp: 'DF 4/1/2023 20:20:03'!
initialize
	super initialize.
	
	bidiParser := BidiPreprocessor new.
	! !

!BidiMorphicScanner methodsFor: 'as yet unclassified' stamp: 'DF 4/1/2023 13:59:33'!
scanCharactersFrom: startIndex to: stopIndex in: anUnicodeString rightX: rightX stopConditions: stops
	"This is the inner loop of text display.
	March through source String from startIndex to stopIndex. If any character is flagged with a
	non-nil entry in stops, then return the corresponding value.
	Determine width of each character.
	If dextX would exceed rightX, then return stops at: 258.
	Advance destX by the width of the character. If stopIndex has been
	reached, then return stops at: 257."

	| nextDestX width |
	lastIndex := startIndex.
	anUnicodeString from: startIndex to: stopIndex do: [ :c |
		"stops are only defined for the first 128 characters
		(entries 128 to 255 are always nil).
		It is OK to just use the first byte in UTF-8"
		c codePoint < 256 ifTrue:[(stops at: c codePoint + 1) ifNotNil: [ :stop | ^stop ] ].
		width := font widthOf:c.
		nextDestX := destX + width.
		nextDestX > rightX ifTrue: [
			^stops at: CharacterScanner crossedXCode ].
		destX := nextDestX.
		lastIndex := lastIndex + 1 ].
	lastIndex := stopIndex.
	^ stops at: CharacterScanner endOfRunCode! !

!BidiInnerTextMorph methodsFor: 'as yet unclassified' stamp: 'DF 3/30/2023 09:15:04'!
drawOn: aCanvas
	"Draw the receiver on a canvas"

	false ifTrue: [ self debugDrawLineRectsOn: aCanvas ].  "show line rects for debugging"

	aCanvas 
		drawBidiTextComposition: self textComposition
		at: `0@0`
		extent: extent
		color: color
		selectionColor: (Theme current textHighlightFocused: self hasKeyboardFocus).

	model actualContents isEmpty ifTrue: [
		owner
			valueOfProperty: #emptyTextDisplayMessage
			ifPresentDo: [ :msg |
				aCanvas
					drawString: msg
					at: `0@0`
					font: nil
					color: Theme current textEmptyDisplayMessage ]].! !

!BidiInnerTextMorph methodsFor: 'as yet unclassified' stamp: 'DF 3/30/2023 09:01:24'!
installEditorAndTextComposition
	"Install an editor for my textComposition. Install also the textComposition."
	| e tc |
	
	"Editor and TextComposition are assigned here atomically."
	e := model editorClass new morph: self.
	e model: model.
	tc := BidiTextComposition new.
	"Keep critical section short"
	self mutex critical: [
		editor := e.
		textComposition := tc.
		tc
			setModel: model;
			extentForComposing: self extentForComposing.
		e textComposition: tc.
		tc editor: e ].
	e setEmphasisHereFromText.
	tc composeAll.
	e resetState.
	self fit.
	self selectionChanged.

	"Add extras. Text Styler and Autocompleter"
	self stylerClass:
		((Preferences at: #syntaxHighlightingAsYouType) ifTrue: [
			model textStylerClass ]).
	self autoCompleterClass:
		model autoCompleterClass! !

!BidiTextModelMorph methodsFor: 'as yet unclassified' stamp: 'DF 3/30/2023 08:57:24'!
innerMorphClass
	^BidiInnerTextMorph! !

!BidiTextModelMorph methodsFor: 'as yet unclassified' stamp: 'DF 3/30/2023 19:37:33'!
withText: aTextOrString
	^self withModel: (BidiTextModel withText: aTextOrString)! !

!BidiTextComposition methodsFor: 'as yet unclassified' stamp: 'DF 4/3/2023 17:00:35'!
addSelectionRectsFrom: characterBlock1 to: characterBlock2 to: aStream
	"Return an array of rectangles representing the area between the two character blocks given as arguments."
	| line1 line2 rects cb1 cb2 w line |
	self halt.
	characterBlock1 <= characterBlock2 
		ifTrue: [cb1 := characterBlock1.  cb2 := characterBlock2]
		ifFalse: [cb2 := characterBlock1.  cb1 := characterBlock2].
	cb1 = cb2 ifTrue: [
		w := 6.
		^ aStream nextPut: (cb1 topLeft - (w@0) corner: cb1 bottomLeft + ((w+1)@0))].
	line1 := self lineIndexFor: cb1 stringIndex.
	line2 := self lineIndexFor: cb2 stringIndex.
	line1 = line2 ifTrue: [
		^ aStream nextPut: (cb1 topLeft corner: cb2 bottomRight)].
	rects := OrderedCollection new.
	rects addLast: (cb1 topLeft corner: (lines at: line1) bottomRight).
	line1+1 to: line2-1 do: [ :i |
		line := lines at: i.
		(line left = rects last left and: [ line right = rects last right ])
			ifTrue: [ "new line has same margins as old one -- merge them, so that the caller gets as few rectangles as possible"
					| lastRect |
					lastRect := rects removeLast.
					rects add: (lastRect bottom: line bottom) ]
			ifFalse: [ "differing margins; cannot merge"
					rects add: line rectangle ] ].
	aStream nextPutAll: rects.
	aStream nextPut: ((lines at: line2) topLeft corner: cb2 bottomLeft)! !

!BidiTextComposition methodsFor: 'as yet unclassified' stamp: 'DF 4/3/2023 15:47:08'!
characterBlockAtPoint: aPoint 
	"Answer a CharacterBlock for the character in the text at aPoint."
	| line block |
	
	line := lines at: (self lineIndexForPoint: aPoint).
	
	block :=(RtLCharacterBlockScanner new text: model actualContents)
		defaultFont: self defaultFont;
		characterBlockAtPoint: aPoint index: nil
		in: line.
		
	^block! !

!BidiTextComposition methodsFor: 'as yet unclassified' stamp: 'DF 4/3/2023 16:15:28'!
characterBlockForIndex: index 
	"Answer a CharacterBlock for the character in text at index."
	| line t |
	line := lines at: (self lineIndexFor: index).
	t := model actualContents.
	^ (RtLCharacterBlockScanner new text: t)
		defaultFont: self defaultFont;
		characterBlockAtPoint: nil index: ((index max: line first) min: t size+1)
		in: line! !

!BidiTextComposition methodsFor: 'as yet unclassified' stamp: 'DF 4/3/2023 16:19:14'!
displaySelectionStartBlock: startBlock stopBlock: stopBlock InLine: line on: aCanvas textTopLeft: textTopLeft  selectionColor: sc
	"textTopLeft is relative to the morph currently being drawn"

	| leftX rightX idx textCursorFont t b textCursorAttributes tmp |

	startBlock ifNil: [^self].	"No selection"
	startBlock = stopBlock 
		ifTrue: [
			"Only show text cursor on line where clicked"
			startBlock textLine first = line first ifFalse: [
				^self ].
			showTextCursor ifTrue: [
				leftX := textTopLeft x + startBlock left.
				idx := startBlock stringIndex.
				textCursorAttributes := editor ifNotNil: [ editor currentAttributes ].
				textCursorFont := textCursorAttributes
					ifNil: [ model actualContents fontAt: idx default: self defaultFont ]
					ifNotNil: [ model actualContents fontIfApplying: textCursorAttributes default: self defaultFont ].
				b := textTopLeft y + line top + line baseline + textCursorFont descent-1.
				t := textTopLeft y + line top + line baseline - textCursorFont ascent+1.
				lastTextCursorRect := nil.
				self
					displayTextCursorAtX: leftX
					top: t
					bottom: b
					emphasis: textCursorFont emphasis
					on: aCanvas
					textLeft: textTopLeft x ]]
		ifFalse: [
			"Test entire selection before or after here"
			(stopBlock stringIndex < line first 
				or: [startBlock stringIndex > (line last + 1)])
					ifTrue: [^self].	"No selection on this line"
			(stopBlock stringIndex = line first 
				and: [stopBlock textLine ~= line])
					ifTrue: [^self].	"Selection ends on line above"
			(startBlock stringIndex = (line last + 1) 
				and: [stopBlock textLine ~= line])
					ifTrue: [^self].
			lastTextCursorRect := nil.
			
			leftX :=  textTopLeft x + (startBlock stringIndex < line first 
				ifTrue: [ line ]
				ifFalse: [ startBlock ]) left.
			rightX :=  textTopLeft x + ((stopBlock stringIndex > (line last + 1) or: [
					stopBlock stringIndex = (line last + 1) 
						and: [stopBlock textLine ~= line]]) 
				ifTrue: [line right]
				ifFalse: [stopBlock left]).
			leftX > rightX ifTrue:[tmp := leftX. leftX := rightX. rightX := tmp].
			aCanvas
				fillRectangle: (leftX @ (line top +  textTopLeft y) corner: rightX @ (line bottom +  textTopLeft y))
				color: sc].	"Selection begins on line below"! !

!ArabicComposer methodsFor: 'as yet unclassified' stamp: 'DF 4/10/2023 21:20:30'!
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

!BidiPreprocessor methodsFor: 'inserting bidi markers' stamp: 'DF 4/2/2023 09:31:38'!
fillIndicesBuffer

	| i |
	
	indices removeAll.
	
	i := 1.
	
	buffer do:[:each |
		each isBidiMarker ifTrue:[indices add: each] ifFalse:[indices add:i. i := i+1] ].
	
	
	! !

!BidiPreprocessor methodsFor: 'inserting bidi markers' stamp: 'DF 4/1/2023 20:35:51'!
insertBidiMarkers

	buffer removeAll.
	
	buffer add: LRI.
	
	state := #init.
	
	1 to: tokens size - 1 do:[:i | 
		self transitionOn: (tokens at:i) first lookAhead: (tokens at:i+1) first. buffer addAll: (tokens at:i) second		].
	
	self transitionOn: (tokens last) first lookAhead: #eos . buffer addAll: (tokens last) second	.	
! !

!BidiPreprocessor methodsFor: 'inserting bidi markers' stamp: 'DF 4/1/2023 20:13:23'!
transitionOn: aSymbol lookAhead: anotherSymbol

	state = #init and: 		aSymbol = #ltr :: ifTrue:[ state := #ltr . buffer add: LRI. ^self ].
	state = #init and: 		aSymbol = #neutral :: ifTrue:[ state := #ltr . buffer add: LRI. ^self ].
	state = #init and: 		aSymbol = #tltr :: ifTrue:[ state := #ltr . buffer add: LRI. ^self ].
	state = #init and: aSymbol = #rtl :: ifTrue:[ state := #rtl . buffer add: RLI. ^self].

	state = #ltr and: 		aSymbol = #ltr :: ifTrue:[ ^self ].
	state = #ltr and: 		aSymbol = #neutral :: ifTrue:[ ^self ].
	state = #ltr and: 		aSymbol = #tltr :: ifTrue:[ ^self ].
	state = #ltr and: aSymbol = #rtl :: ifTrue:[ state := #rtl . buffer add: RLI. ^self].
	
	state = #rtl and: aSymbol = #rtl :: ifTrue:[^self].
	state = #rtl and: aSymbol = #neutral and: anotherSymbol ~= #ltr :: ifTrue:[^self].
	state = #rtl and: aSymbol = #neutral and: anotherSymbol = #ltr :: ifTrue:[state := #ltr. buffer add: PDI. ^self].
	state = #rtl and: aSymbol = #ltr :: ifTrue:[ state := #ltr . buffer add: PDI. ^self].
	state = #rtl and: aSymbol = #tltr :: ifTrue:[state := #tltr . buffer add: LRI. ^self].

	state = #tltr and: aSymbol = #tltr :: ifTrue:[^self].
	state = #tltr and: aSymbol = #neutral :: ifTrue:[state := #rtl . buffer add: PDI. ^self].
	state = #tltr and: aSymbol = #ltr :: ifTrue:[ state := #ltr . ^self].
	state = #tltr and: aSymbol = #rtl :: ifTrue:[state := #rtl . buffer add: PDI. ^self].
! !

!BidiPreprocessor methodsFor: 'parsing' stamp: 'DF 4/2/2023 09:45:31'!
flatten: aSequence

	aSequence isCollection ifTrue:[
		^aSequence inject: OrderedCollection new into:[:acc :each | acc addAll:(self flatten: each). acc ] ].
	
	^{aSequence}! !

!BidiPreprocessor methodsFor: 'parsing' stamp: 'DF 4/2/2023 09:32:32'!
parse: anOrderedSequence

	stack removeAll.
			
	anOrderedSequence do:[ :codePoint |
	
		codePoint = PDI 
			ifTrue:[	self reduce] ifFalse:[self shift: codePoint].
	].

	[stack size = 1] whileFalse:[self reduce].
	

	! !

!BidiPreprocessor methodsFor: 'parsing' stamp: 'DF 4/2/2023 09:42:54'!
reduce

	| seq |
	
	seq := OrderedCollection new.
	
	[stack last = RLI  or: stack last = LRI ]
		whileFalse:[
			seq add: stack last. stack removeLast ].
		
	stack last = LRI  ifTrue:[seq := seq reverse].
	
	stack removeLast. stack add: seq.
	! !

!BidiPreprocessor methodsFor: 'parsing' stamp: 'DF 4/2/2023 09:41:51'!
shift: aCodePoint
	stack add: aCodePoint ! !

!BidiPreprocessor methodsFor: 'initialization' stamp: 'DF 4/2/2023 09:27:52'!
initialize

	input := OrderedCollection new.
	
	tokens := OrderedCollection new.

	buffer := OrderedCollection new.
	
	stack := OrderedCollection new.
	
	indices := OrderedCollection new.
! !

!BidiPreprocessor methodsFor: 'as yet unclassified' stamp: 'DF 4/2/2023 09:38:57'!
output
	^output! !

!BidiPreprocessor methodsFor: 'as yet unclassified' stamp: 'DF 4/2/2023 09:39:01'!
permuted
	^permuted! !

!BidiPreprocessor methodsFor: 'as yet unclassified' stamp: 'DF 4/2/2023 10:16:33'!
process: aString

	aString ifEmpty:[output := aString. ^self].
	
	self scan: aString.
	
	self insertBidiMarkers.
	
	self fillIndicesBuffer.
	
	self parse:buffer.
	
	output := UnicodeString newFrom: (self flatten: stack last).
	
	self parse: indices.
	
	permuted := self flatten: stack last.
	
	! !

!BidiPreprocessor methodsFor: 'scanning' stamp: 'DF 4/1/2023 20:00:13'!
buildToken: aSymbol

	| s |
	
	s := OrderedCollection new.
	
	[index <= input size and:[input at:index :: writingDirection = aSymbol] ]
		whileTrue:[s add: (input at:index) . index := index + 1 ].
		
	^{aSymbol . UnicodeString newFrom: s  }! !

!BidiPreprocessor methodsFor: 'scanning' stamp: 'DF 4/1/2023 20:15:48'!
scan: aString

	| token |
	
	input removeAll.
	
	tokens removeAll.
	 
	index := 1.
	
	input addAll: aString.
	
	token := self tokenize.
	
	[token first = #eos ] whileFalse:[
		tokens add: token.
		token := self tokenize ].
	! !

!BidiPreprocessor methodsFor: 'scanning' stamp: 'DF 4/1/2023 20:03:27'!
tokenize

	| direction |
	
	index > input size ifTrue:[^{#eos . ''} ].
	
	direction := 	input at:index :: writingDirection.
	
	direction = #ltr ifTrue:[		^self buildToken:#ltr ].
	
	direction = #neutral ifTrue:[		^self buildToken:#neutral ].
	
	direction = #rtl ifTrue:[		^self buildToken:#rtl ].
	
	direction = #tltr ifTrue:[		^self buildToken:#tltr ].
	
		! !

!BidiPreprocessor class methodsFor: 'as yet unclassified' stamp: 'DF 4/1/2023 17:05:20'!
initialize

	"self initialize"
	
	LRI := UnicodeCodePoint codePoint: 16x2066.
	RLI := UnicodeCodePoint codePoint: 16x2067.
	PDI := UnicodeCodePoint codePoint: 16x2068.! !

!UnicodeCodePoint methodsFor: '*BidiExploration' stamp: 'DF 4/2/2023 09:29:37'!
isBidiMarker
	
	^ value = 16x2066 or: value = 16x2067 or: value = 16x2068! !

!MorphicCanvas methodsFor: '*BidiExploration' stamp: 'DF 3/30/2023 09:33:25'!
drawBidiString: aString from: firstIndex to: lastIndex at: aPoint font: font color: aColor
	"Eventually, convert all senders to the 'Baseline' protocol"

	^self drawBidiString: aString from: firstIndex to: lastIndex
		atBaseline: aPoint + (0@(font ascent + font lineGap-1))
		font: font color: aColor! !

!MorphicCanvas methodsFor: '*BidiExploration' stamp: 'DF 3/30/2023 09:30:10'!
drawBidiString: aString from: firstIndex to: lastIndex atBaseline: aPoint font: font color: aColor
	self subclassResponsibility ! !

!MorphicCanvas methodsFor: '*BidiExploration' stamp: 'DF 3/30/2023 09:15:42'!
drawBidiTextComposition: aTextComposition at: drawingPosition extent: anExtent color: c selectionColor: sc
	"strict boolean controls whether to avoid or include the last line, if it doesn't fully fit in visibleTextBounds"

	self drawBidiTextComposition: aTextComposition at: drawingPosition extent: anExtent color: c selectionColor: sc avoidOverhang: false! !

!MorphicCanvas methodsFor: '*BidiExploration' stamp: 'DF 4/1/2023 14:46:30'!
drawBidiTextComposition: aTextComposition at: drawingPosition extent: anExtent color: c selectionColor: sc avoidOverhang: strict
	"strict boolean controls whether to avoid or include the last line, if it doesn't fully fit in visibleTextBounds"

	| displayScanner leftInRun line possiblyVisible firstLineIndex lastLineIndex |

	possiblyVisible := currentTransformation boundsOfInverseTransformOf: clipRect.
	possiblyVisible := (possiblyVisible translatedBy: drawingPosition negated) intersect: (0@0 extent: anExtent).

	displayScanner := BidiMorphicScanner new
		defaultFont: aTextComposition defaultFont;
		text: aTextComposition textComposed 
		foreground: c.
	displayScanner canvas: self.

	leftInRun := 0.
	"Take clipRect into account. Extrememly fast scrolls and redraws of huge files (like .sources)"
	firstLineIndex := aTextComposition lineIndexForPoint: (possiblyVisible topLeft max: `0@0`).
	lastLineIndex := aTextComposition lineIndexForPoint: (possiblyVisible bottomRight min: anExtent).
	firstLineIndex
		to: lastLineIndex
		do: [ :i |
			line := aTextComposition lines at: i.
			(strict not or: [ line top + line baseline < possiblyVisible bottom ]) ifTrue: [
				aTextComposition
					displaySelectionInLine: line
					on: self
					textTopLeft: drawingPosition
					selectionColor: sc.
				leftInRun := displayScanner displayLine: line textTopLeft: drawingPosition leftInRun: leftInRun ]]! !

!VectorCanvas methodsFor: '*BidiExploration' stamp: 'DF 3/30/2023 09:32:25'!
drawBidiString: aString from: firstIndex to: lastIndex atBaseline: aPoint font: aTrueTypeFont color: aColor
	"Answer position to place next glyph"
	"
| s c f |
c _ VectorCanvas onForm: Display.
c geometryTransformation: (AffineTransformation withRadians: 0.1).
f _ FontFamily familyName: 'DejaVu Sans' pointSize: 72.
s _ 'Latin text in VectorGraphics'.
(c drawString: s from: 1 to: s size atBaseline: 100@100 font: f color: Color black) print.
c strokeWidth: 1 color: Color red do: [ c moveTo: 100@100; lineTo: 1000@100 ].
Display forceToScreen
	"
	| p1 answer s |
	
	"Don't waste any time if NOP"
	lastIndex = 0 ifTrue: [
		^nil ].

	currentTransformation isPureTranslation ifTrue: [
		(Preferences at: #cacheTrueTypeGlyphs) ifTrue: [
			p1 := currentTransformation transform: aPoint roundedHAFZ.
			p1 := p1 + (0@(0 - (aTrueTypeFont ascent + aTrueTypeFont lineGap-1))).
			p1 := p1 roundedHAFZ.
			answer := aString asUnicodeString displayOnBitBltCanvasEngine: auxBitBltEngine
				from: firstIndex to: lastIndex at: p1 font: aTrueTypeFont color: aColor.
			answer ifNotNil: [
				engine updateMorphBoundsLeft: p1 x top: p1 y
					right: answer x bottom: answer y ].
			^answer ]].

	s := aString copyFrom: firstIndex to:lastIndex.
	
	^super drawString: s from: 1 to: s size atBaseline: aPoint font: aTrueTypeFont color: aColor! !

!BitBltCanvas methodsFor: '*BidiExploration' stamp: 'DF 3/30/2023 10:19:25'!
drawBidiString: aString from: firstIndex to: lastIndex atBaseline: aPoint font: font color: aColor
	"Answer position to place next glyph
	Answer nil if nothing was done"

	| p1 s |
	"Don't waste any time if NOP"
	lastIndex = 0 ifTrue: [
		^nil ].

	p1 := currentTransformation transform: aPoint roundedHAFZ.
	p1 := p1 + (0@(0 - (font ascent + font lineGap-1))).
	p1 := p1 roundedHAFZ.
	engine colorMap: nil.
	s := aString asUnicodeString copyFrom: firstIndex to:lastIndex :: reverse.
	^s displayOnBitBltCanvasEngine: engine
		from: 1
		to: s size
		at: p1
		font: font
		color: aColor! !
ArabicComposer initialize!
BidiPreprocessor initialize!
