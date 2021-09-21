## Development Roadmap

### Version 0.01
Map in place. Generated from bitmap, allows quick level creation. 
### Version 0.02
Was able to draw objects on fixed places on the map. 
### Version 0.03
Very basic movement task, characters can now visually 
twiddle their thumbs when idle.
### Version 0.04
Added a 'journey' task. An attempt at simple, randomized pathfinding
for longer distances. 

### Version 0.1

All of the characters can run around like little critters. 
Do a handful of tasks each day in accordance with their traits, 
and take care of themselves, keeping their levels in check. 

Debugging tools: 
  * visualized task assignment. 
  * log of completed tasks and events. 


### Version 0.1 to 0.5

Improved map generation:
  * Redo tile atlas, to be sorted by land speed. 
    * first line is all coastal tiles
    * second line is all forest tiles, etc. 
  * Use a lighter color to indicate transition points
    So the software can use those as pivot points when
    going back through the file with "surrounds"

Move many of the geometry, map, math functions to a dedicated library file. 
  Surrounds, distance, direction, etc. 

All the building blocks for the final game are in place. 
  * Go home. 
  * Fishing
  * Eating
  * Fire
  * Inventory, Items
  * Sleeping
  * Dirt roads
  * Memories, some emotional response to connections to objects, names, people.
  * Memory-based pathfinding
  * Landmark memory
  * Guns, basic combat
  * Seeing and noticing an item. 
  * Stories: objects that are passed around
  * Kidnapping
  * Risk Assessment. Present/Future Pain, Present/Future Pleasure

Simple stories to tell:
  * A guy is hungry, goes to catch a fish, cooks and eats it. 
  * A hike from one end of the island to the next. 
    * taking naps as needed
    * eating packed food 
  * A man is looking for his knife, tells others. 
    Someone sees it the next day and tells him where it is. 

### Version 0.751 to 1

Interiors
  * Cannot be used until out-of-sight state is handled.
Value Assessment
  * each character will value objects, in a unique way. 

### Version 1

This may not be a very enjoyable game, but it should be complete. 
You will play as a simple warrior in a small, 2d open world. 
If you read the instructions and follow the proper hero's journey, 
you will be successful in bringing freedom back to your village. 
While also providing resources for them to prosper like never before. 

But, you can follow that plan, as much or as little as you want to. 

  * Each character's behaviour is dictated by:
    * Skill set
    * Big 5 Personality
    * Maslow's Hierarchy
    * Natural Laws of Justice
    * Tasks, Goals, Objectives

### Version 2

Add memory and time constraints to tasks assigned. 
So that a forgetful character might forget some smaller tasks, 
by the time he gets to them. 
