Class {
	#name : #CDBehaviorDefinitionNode,
	#superclass : #CDNode,
	#instVars : [
		'classNameNode',
		'slotNodes',
		'traitDefinition',
		'className',
		'classKind'
	],
	#category : #'ClassParser-Model'
}

{ #category : #accessing }
CDBehaviorDefinitionNode >> addSlot: aCDSlotNode [
	
	slotNodes add: aCDSlotNode.
	children add: aCDSlotNode
]

{ #category : #accessing }
CDBehaviorDefinitionNode >> classKind: aString [ 
	classKind := aString
]

{ #category : #accessing }
CDBehaviorDefinitionNode >> className [

	^ className
]

{ #category : #accessing }
CDBehaviorDefinitionNode >> className: aName astNode: astNode [

	className := aName.
	classNameNode := astNode.
	children add: astNode
]

{ #category : #accessing }
CDBehaviorDefinitionNode >> classNameNode [
	
	^ classNameNode
]

{ #category : #accessing }
CDBehaviorDefinitionNode >> classNameNode: aNode astNode: astNode [

	classNameNode := aNode.
	children add: aNode
]

{ #category : #'initialize-release' }
CDBehaviorDefinitionNode >> initialize [
	super initialize.
	slotNodes := OrderedCollection new
]

{ #category : #testing }
CDBehaviorDefinitionNode >> isBytes [
	
	^ classKind = #variableByteSubclass:
]

{ #category : #testing }
CDBehaviorDefinitionNode >> isEphemeron [
	
	^ classKind = #ephemeronSubclass:
]

{ #category : #testing }
CDBehaviorDefinitionNode >> isImmediate [
	
	^ classKind = #immediateSubclass:
]

{ #category : #testing }
CDBehaviorDefinitionNode >> isNormal [
	
	^ classKind = #subclass:
]

{ #category : #testing }
CDBehaviorDefinitionNode >> isVariable [
	
	^ classKind = #variableSubclass:
]

{ #category : #testing }
CDBehaviorDefinitionNode >> isWeak [
	
	^ classKind = #weakSubclass:
]

{ #category : #testing }
CDBehaviorDefinitionNode >> isWords [
	
	^ classKind = #variableWordSubclass:
]

{ #category : #accessing }
CDBehaviorDefinitionNode >> slotNodes [
	
	^ slotNodes
]

{ #category : #accessing }
CDBehaviorDefinitionNode >> slots [

	^ slotNodes
]

{ #category : #accessing }
CDBehaviorDefinitionNode >> slots: aCollection [ 
	
	slotNodes := aCollection.
	children addAll: aCollection
	
]

{ #category : #accessing }
CDBehaviorDefinitionNode >> traitDefinition: aNode [

	traitDefinition := aNode.
	children add: aNode.
]
