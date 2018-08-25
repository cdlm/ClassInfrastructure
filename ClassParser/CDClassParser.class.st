Class {
	#name : #CDClassParser,
	#superclass : #Object,
	#instVars : [
		'classDefinition',
		'subclass'
	],
	#category : #ClassParser
}

{ #category : #parsing }
CDClassParser class >> parse: aString [ 
	
	^ self new parse: aString
]

{ #category : #accessing }
CDClassParser >> className: aNode [ 
	
	classDefinition classNameNode: aNode astNode: aNode
]

{ #category : #accessing }
CDClassParser >> classVariableNames: aNode [ 
	
	| sharedSlots sharedSlotsNodes |
	sharedSlots := aNode value substrings collect: [ :each | ClassVariable named: each ].
	sharedSlotsNodes := sharedSlots collect: [ :each | CDSharedSlotNode slot: each node: aNode ].
	classDefinition sharedSlots: sharedSlotsNodes
]

{ #category : #initialization }
CDClassParser >> initialize [

	super initialize.
	classDefinition := CDClassDefinition new
]

{ #category : #accessing }
CDClassParser >> instanceVariablesString: aNode [
	
	| slots slotNodes |
	slots := aNode value substrings collect: [ :substring | substring asValidInstVarName asSlot ].
	slotNodes := slots collect: [ :slot | CDSlotNode slot: slot node: aNode ].
	classDefinition slots: slotNodes
]

{ #category : #accessing }
CDClassParser >> package: aNode [ 
	
	classDefinition packageNameNode: aNode astNode: aNode
]

{ #category : #parsing }
CDClassParser >> parse: aString [ 
	
	| expressionTree |
	expressionTree := RBParser parseExpression: aString.
	classDefinition definitionExpressionTree: expressionTree.
	expressionTree acceptVisitor: self.
	^ classDefinition
]

{ #category : #parsing }
CDClassParser >> parseSelectorPart: aString withArgument: aNode [ 
	
	"We could do this with reflection, or with a dictionary and closures.
	I chose to use a series of if for readability only."
	
	aString = 'subclass:'
		ifTrue: [ ^ self className: aNode ].
	aString =	 #instanceVariableNames:
		ifTrue: [ ^ self instanceVariablesString: aNode ].
	aString =	 #classVariableNames:
		ifTrue: [ ^ self classVariableNames: aNode ].
	aString =	 #package:
		ifTrue: [ ^ self package: aNode ].
	aString =	 #uses:
		ifTrue: [ ^ self traitDefinition: aNode ].
	
	self halt.
]

{ #category : #accessing }
CDClassParser >> superclass: aSuperclassNode [

	classDefinition superclassNameNode: aSuperclassNode astNode: aSuperclassNode
]

{ #category : #accessing }
CDClassParser >> traitDefinition: aNode [
	
	classDefinition traitDefinition: aNode
]

{ #category : #visiting }
CDClassParser >> visitMessageNode: aRBMessageNode [
	
	self superclass: aRBMessageNode receiver.
	
	aRBMessageNode selectorParts
		with: aRBMessageNode arguments
		do: [ :selectorPart :argument |
			self parseSelectorPart: selectorPart withArgument: argument ]
]