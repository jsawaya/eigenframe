# Variable
## schema pattern

* type = "Variable"
* name
* id (optional)
* method = "set" 
 class = boolean | integer | long | string
 value 

* method = "toast" - shows the value as a transient toast message 

Related:
[Define](Define.md)  
[Variable](Variable.md)  
[Cache](Cache.md)  
[ListView](ListView.md)  
[ActionList](ActionList.md)  


Example:
```json
  {
    "type": "Variable",
    "name": "IsSourceButton",
    "method": "set",
    "class": "boolean",
    "value": true
  }
```

```json
  {
    "type": "Variable",
    "name": "IsSourceButton",
    "method": "toast"
  }
```


