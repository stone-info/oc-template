/* 
  README.txt
  objc_template

  Created by stone on 2019/3/31.
  Copyright © 2019 stone. All rights reserved.
*/

json-server --static objc_template/server/public --watch objc_template/server/db.json --routes objc_template/server/routes.json  --port 7000




Start JSON Server with --routes option.

json-server db.json --routes routes.json
Now you can access resources using additional routes.

/api/posts # → /posts
/api/posts/1  # → /posts/1
/posts/1/show # → /posts/1
/posts/javascript # → /posts?category=javascript
/articles?id=1 # → /posts/1
