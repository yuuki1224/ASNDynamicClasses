#ASNDynamicClasses
##Usage
You can create ObjectiveC Classes from json file on the runtime.

```objectivec
ASNDynamicClasses *dynamicClasses = [ASNDynamicClasses alloc] initWithPath:@"dummy"];
NSArray *generatedClasses = dynamicClasses.generatedClasses;
```````

```dummy.json
{
    "User" : [
        "name",
        "age",
        "sex"
    ],
    "Production" : [
        "name",
    "age",
    "sex"
    ]
}
```````

You can create User and Production Classes.
They have 3 properties each other. Of Course, You can change them.

##Todo
- Demo doesn't work kkk
- A lot of functions

##Author
Yuki Asano, yuuki.1224.softtennis@gmail.com

