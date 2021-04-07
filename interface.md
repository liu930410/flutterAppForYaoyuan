## loginPage(mainPage)

# 输入用户名和密码，post 请求服务器响应，请求格式 contentType: "application/json",请求路径为 config.dart 中的 loginUrl,

# 如果返回 ture 则跳转下一界面，若为 false，则显示用户名密码错误，若服务器响应超时，则显示网络异常

# json 格式 {userName:userName,password:password}

## userInfoInputPage(secondPage)

# 用户输入信息，唯一识别号从服务器 get 请求获取，请求格式默认，响应格式 responseType: ResponseType.plain，请求路径为 config.dart 中的 getUniIDUrl

# 点击下一步，将该页面值通过路由传值传递到下一页

## itemInfoInputPage(thirdPage)

# 仪器信息输入，增加流量行或删减流量行可以动态改变 tableRow 长度，至少存在一行，点击提交，通过 post 请求提交

# 请求格式 contentType: "application/json",请求路径为 config.dart 中的 postUrl,

# 如果返回 ture 则提示提交成功跳转至 userInfoInputPage 界面，若为 false，则显示上传失败，若服务器响应超时，则显示网络异常

# json 格式 {"uniCode": uniCode, "apartment": apartment,"location": location,"itemName": itemName,"specification": specification,

### 唯一识别号， 委托单位， 校准地点，仪器名称，型号规格

# "manufacturer": manufacturer,"factoryNumber": factoryNumber,"itemQualified": itemQualified,"usedProduct": usedProduct,

### 制作单位，出厂编号，外观及功能行检查是否合格，本次校准所用输注管路

# "flow0":"flow0",flow1":"flow1",flow2":"flow2",flow3":"flow3"} 若流量行大于一行，flow 依次追加

### 设定值，实际值，实际值，实际值
