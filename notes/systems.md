## Memory Stuff

We start with the level, generated from a bitmap. 
  * **must** be rectangular. Not irregular shapes.
  * 
Objects
  * Terrain, collection of all tile numbers. For knowing what tiles are which. 
  * Characters, 
    * Includes vehicles. For now at least. 
    * A flat list, not a matrix
  * Map & Objects
    * Y{ X{ T, {Object(s)} } }   |   tile = map[y][x][1]   obj = map[y][x][2][1]
    * Have no agency, currently will not move, unless picked up. 
    * Their positions are defined by their place in the map matrix


Each person has a lot in common. So let's build up from animals to people. 

  * Each character's behaviour is dictated by:
    * Skill set
    * Big 5 Personality
    * Natural Laws of Justice
    * Tasks, Goals, Objectives
    * Maslow's Hierarchy

## Physical Traits
  * Speed
  * Need for sleep
  * Weight, Height
  * Strength

## Basic RTS-style needs. 
  Feelings --> Actions
  * Health
    * Initially we'll just use a standard health bar. 
      * Renewed by sleep, and a bit by food, and a bit by time. 
    * May progress to include long term injuries. Body parts, etc.
  * Hunger
    * rate controlled by experiences & physical traits
    * below 35%, check storage
    * below 25%, fish
    * below 15%, get fruit
  * Thirst
    * rate controlled by experiences & physical traits
    * below 40%, dip from well
  * Tiredness
    * dwindles at steady rate, slightly affected by:
      * physical characteristics
      * experiences
      * vigour
    * above 70%, find place to rest
      * Hammock
      * Tent with cot
      * Shack with bed
  * Vigour
    * Improved by sleep and/or meditation. 
    * Consumed depending on personality and experiences. 

## Personality

Let's use Hexaco as a model. 

  * Conscientiousness
  * Agreeableness
  * Extroversion
  * Openness
  * Emotionality
  * Honest-Humility

### Actions dictated by personality. 

  * Checking one's own needs and state. 
  * Stepping away from group for any reason. 
  * Interrupting a busy person
  * Distracted by one's own feelings
  * Ideal proximity to people
  * Likelihood of sharing resources
  * Likelihood of sharing stories
  * Immitation
  * Following orders
  * likelihood of stealing, commiting violence
  * Chances of defending vs attacking

## Social Habits
  * Occasional bonfires
  * gatherings of 3 or more involve sharing stories
  * friends sharing a story one-on-one


## Buildings and Functions

At first, there will be no interior spaces. 
People are either inside, or they are use it externally. 

## Objects and Inventory

All items are tracked, can be held, wear, tear, etc.

## Stories

Simply a more complex object that is less physical. 
No weight, affects emotions, has a short shelf life.
Each story tracks who it has interacted with. 
  * Has half-life as the story gets shared
  * Once everyone is aware of it, the story transforms into a memory. 
  * If it isn't shared and < 3 people have been told, then it can be kept
  * Memories have a minimal impact when shared, cannot be traded

## Trading

If A wants a and B wants b, they can trade, or give freely

## Fire

Every living thing will be damaged by contact with fire
Only flamable creatures and things can catch fire. 

## Buildings & Vehicles

No interiors. Simply a vessel that allows 
characters and items to be stacked inside. 
All have a maximum occupancy

## Pathfinding

So the sketchy and blind algorithm I've settled on is fine for now. 
It can't see around large chasms, but it stumbles its way along well enough. 
What would be better right now, is to have a memory system for 
useful spots and fast routes. 

Here are my thoughts so far

  * as people walk over tiles they become worn, until you get a dirt road. 
    Would require a duplicate map buffer for the data. 
  * People can construct a road, somehow using it is stored as memories
  * Implement a proper pathfinding algorithm. Limited radius?

