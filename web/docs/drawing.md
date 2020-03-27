# Draw
## schema pattern

{
 "type": "Draw",
 "version": 1,
 "color": "#ffffff00",
 "stroke_width": 4,
 "event_list": [ events ]
}

event schema:
{
	a:
   ACTION_DOWN = 0;
   ACTION_MOVE = 2;
   ACTION_UP = 1;

	x: relative x-value [0.0 - 1.0]
	y: relative y-value [0.0 - 1.0]
}

Related:
[Define](Define.md) 
[Variable](Variable.md) 
[Cache](Cache.md) 
[JavaScript](JavaScript.md) 
[UrlRequest](UrlRequest.md) 
[SecureShell](SecureShell.md) 
[SecureFtp](SecureFtp.md)

Example:
```json
{
 "type": "Draw",
 "version": 1,
 "color": "#ffffff00",
 "stroke_width": 4,
 "event_list": [
  {
   "a": 0,
   "x": 0.38055557012557983,
   "y": 0.24637681245803833
  },
  {
   "a": 2,
   "x": 0.38055557012557983,
   "y": 0.24637681245803833
  },
  {
   "a": 2,
   "x": 0.37862518429756165,
   "y": 0.24698148667812347
  },
  {
   "a": 1,
   "x": 0.2787036895751953,
   "y": 0.4598662257194519
  }
 ]
}
```
