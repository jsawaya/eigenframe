# Variable
## schema pattern

* type = "Variable"
* name
* id (optional)
* method
** set 
 class = boolean | integer | long | string
 value 

** toast - shows the value as a transient toast message 


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


