# -*- coding: utf-8 -*-
"""
网络请求API
"""
import json
import random
# 设置当前路径
import sys
import time
from datetime import datetime

import pymysql.cursors
from flask import request, session

sys.path.insert(0, "D:\\WorkSpace\\Python\\style_transform\\music_style_transform\\")
sys.path.append("/workspace/python/music_style_transform/")

from api import create_app
from dbconn import get_db
from utils import allow_cors, ResponseCode, verify_phone, upload_image, DatetimeEncoder, response_json, upload_file, \
    send_feedback_mail, trans_music_util, send_mail, verify_mail

app = create_app()
app.after_request(allow_cors)
app.after_request(response_json)


@app.route('/register', methods=['POST'])
def register():
    """
    用户注册，post请求，请求体位于body
    ```json
    {
        "phone": "string, 用户手机号",
        "mail": "string 用户邮箱",
        "password": "string,哈希加密后的密码",
        "username": "string,用户昵称",
        "avatar": "base64格式，用户头像图片"
    }
    ```
    :return: data字段 注册成功返回userInfo 其余为空
    """
    # 获取request的body里面的数据
    body_data = request.get_json()
    username = body_data.get('username', 'User')
    phone = body_data.get('phone')
    mail = body_data.get('mail')
    password = body_data.get('password')
    avatar = body_data.get('avatar')
    # 获取数据库连接
    db_conn = get_db()
    # response
    code = ResponseCode.success
    msg = ''
    userInfo = None

    if not phone:
        code = ResponseCode.param_missing
        msg = '缺少手机号'
    elif not verify_phone(phone):
        code = ResponseCode.param_error
        msg = '手机号格式错误'
    elif not password:
        code = ResponseCode.param_missing
        msg = '缺少密码'
    else:
        pass

    if avatar and avatar != '':
        try:
            avatar = upload_image(avatar)
        except RuntimeError:
            avatar = None

    if code is ResponseCode.success:
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)
        try:
            cursor.execute("SELECT id FROM t_user WHERE phone = %s", (phone))
            result = cursor.fetchone()
            if result:
                code = ResponseCode.existed_error
                msg = '该手机号已注册'
            else:
                try:
                    cursor.execute(
                        "INSERT INTO db_music_trans.t_user(phone,mail,username,password,avatar) VALUES (%s,%s,%s,%s,%s)",
                        (phone, mail, username, password, avatar))
                    db_conn.commit()
                    code = ResponseCode.success
                    msg = '已成功注册'
                    cursor.execute(
                        "SELECT id, phone,username,avatar,created FROM db_music_trans.t_user WHERE phone = %s", (phone))
                    userInfo = cursor.fetchone()
                    session.clear()
                    session['user_id'] = userInfo['id']
                    session['user_phone'] = userInfo['phone']
                except db_conn.IntegrityError:
                    code = ResponseCode.existed_error
                    msg = '该手机号已注册'
        except db_conn.Error:
            pass
        finally:
            # 释放游标
            cursor.close()
    result = dict(code=code, data=userInfo, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


@app.route('/register_mail', methods=['POST'])
def register_with_mail():
    """
    用户注册，post请求，请求体位于body
    ```json
    {
        "phone": "string, 用户手机号", // 非必须
        "mail": "string 用户邮箱",
        "password": "string,哈希加密后的密码",
        "username": "string,用户昵称",
        "avatar": "base64格式，用户头像图片"
    }
    ```
    :return: data字段 注册成功返回userInfo 其余为空
    """
    # 获取request的body里面的数据
    body_data = request.get_json()
    username = body_data.get('username', 'User')
    phone = body_data.get('phone')
    mail = body_data.get('mail')
    password = body_data.get('password')
    avatar = body_data.get('avatar')
    # 获取数据库连接
    db_conn = get_db()
    # response
    code = ResponseCode.success
    msg = ''
    userInfo = None

    if not mail:
        code = ResponseCode.param_missing
        msg = '缺少邮箱'
    elif not verify_mail(mail):
        code = ResponseCode.param_error
        msg = '邮箱格式错误'
    elif not password:
        code = ResponseCode.param_missing
        msg = '缺少密码'
    else:
        pass

    if avatar and avatar != '':
        try:
            avatar = upload_image(avatar)
        except RuntimeError:
            avatar = None

    if code is ResponseCode.success:
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)
        try:
            cursor.execute("SELECT id FROM t_user WHERE mail = %s", (mail))
            result = cursor.fetchone()
            if result:
                code = ResponseCode.existed_error
                msg = '该邮箱已注册'
            else:
                try:
                    cursor.execute(
                        "INSERT INTO db_music_trans.t_user(phone,mail,username,password,avatar) VALUES (%s,%s,%s,%s,%s)",
                        (phone, mail, username, password, avatar))
                    db_conn.commit()
                    code = ResponseCode.success
                    msg = '已成功注册'
                    cursor.execute(
                        "SELECT id, phone,mail,username,avatar,created FROM db_music_trans.t_user WHERE mail = %s",
                        (mail))
                    userInfo = cursor.fetchone()
                    session.clear()
                    session['user_id'] = userInfo['id']
                    session['user_phone'] = userInfo.get('phone')
                    session['user_mail'] = userInfo.get('mail')
                except db_conn.IntegrityError:
                    code = ResponseCode.existed_error
                    msg = '该邮箱已注册'
        except db_conn.Error:
            code = ResponseCode.db_conn_error
            msg = '数据库链接错误'
        finally:
            # 释放游标
            cursor.close()
    result = dict(code=code, data=userInfo, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


@app.route('/login', methods=['POST'])
def user_login():
    """
    用户登录，post请求，请求体位于body
    ```json
    {
        "phone": "string,用户手机号",
        "password": "string,哈希加密后的密码"
    }
    ```
    :return: 登陆成功返回userInfo,其余情况为空
    """
    body_data = request.get_json()
    phone = body_data.get('phone')
    password = body_data.get('password')
    code = ResponseCode.success
    msg = ''
    userInfo = None

    if not phone:
        code = ResponseCode.param_missing
        msg = '缺少手机号'
    elif not verify_phone(phone):
        code = ResponseCode.param_error
        msg = '手机号不合法'
    elif not password:
        code = ResponseCode.param_missing
        msg = '密码错误'
    else:
        pass

    if code is ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)
        try:
            cursor.execute(
                "SELECT id, phone,username,avatar,created FROM db_music_trans.t_user WHERE phone = %s AND password = %s",
                (phone, password))
            userInfo = cursor.fetchone()
            if not userInfo:
                code = ResponseCode.db_not_found
                msg = '账号或密码错误'
            else:
                session.clear()
                session['user_id'] = userInfo['id']
                session['user_phone'] = userInfo['phone']
        except db_conn.Error:
            code = ResponseCode.db_conn_error
            msg = '数据库连接错误'
        finally:
            # 释放游标
            cursor.close()

    result = dict(code=code, data=userInfo, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


@app.route('/login_mail', methods=['POST'])
def user_login_with_mail():
    """
    用户登录，post请求，请求体位于body
    ```json
    {
        "mail": "string,用户邮箱",
        "password": "string,哈希加密后的密码"
    }
    ```
    :return: 登陆成功返回userInfo,其余情况为空
    """
    body_data = request.get_json()
    mail = body_data.get('mail')
    password = body_data.get('password')
    code = ResponseCode.success
    msg = ''
    userInfo = None

    if not mail:
        code = ResponseCode.param_missing
        msg = '缺少邮箱'
    elif not verify_mail(mail):
        code = ResponseCode.param_error
        msg = '手机号不合法'
    elif not password:
        code = ResponseCode.param_missing
        msg = '密码错误'
    else:
        pass

    if code is ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)
        try:
            cursor.execute(
                "SELECT id, phone,mail,username,avatar,created FROM db_music_trans.t_user "
                "WHERE mail = %s AND password = %s",
                (mail, password))
            userInfo = cursor.fetchone()
            if not userInfo:
                code = ResponseCode.db_not_found
                msg = '账号或密码错误'
            else:
                session.clear()
                session['user_id'] = userInfo['id']
                session['user_phone'] = userInfo.get('phone')
                session['user_mail'] = userInfo.get('mail')
        except db_conn.Error:
            code = ResponseCode.db_conn_error
            msg = '数据库连接错误'
        finally:
            # 释放游标
            cursor.close()

    result = dict(code=code, data=userInfo, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


@app.route('/logout', methods=['POST'])
def user_logout():
    """
    用户退出登录
    :return: data域为空
    """
    session.clear()
    result = dict(code=ResponseCode.success, msg='退出登录成功')
    return json.dumps(result)


@app.route('/remove_account', methods=['DELETE'])
def remove_account():
    """
    账户注销，级联删除数据库中用户的有关信息,user_id位于URL参数中
    ?user_id = <>
    :return: data域为空
    """
    user_id = session.get('user_id')
    if user_id is None:
        user_id = request.args.get('user_id')
    db_conn = get_db()
    cursor = db_conn.cursor()
    code = ResponseCode.success
    msg = ''

    if user_id:
        try:
            cursor.execute("DELETE FROM db_music_trans.t_user WHERE id = %s", (int(user_id)))
            db_conn.commit()
            code = ResponseCode.success
            msg = '账户注销成功'
        except db_conn.Error:
            db_conn.rollback()
            code = ResponseCode.db_conn_error
            msg = '数据库错误'
        finally:
            cursor.close()
    else:
        code = ResponseCode.db_not_found
        msg = '账户不存在'
    result = dict(code=code, msg=msg)

    return json.dumps(result)


user_mail_code = dict()


@app.route('/send_verify_code', methods=['POST'])
def get_mail_verify_code():
    """
    用户修改密码获取邮箱验证码数据位于body
    {
        "mail":邮箱
    }
    :return:
    """
    code = ResponseCode.success
    msg = ''
    data = False

    body_data = request.get_json()
    mail_addr = body_data.get('mail', str)
    if mail_addr is None or str(mail_addr).find('@') < 0:
        code = ResponseCode.param_missing
        msg = '邮箱格式错误'

    if code == ResponseCode.success:
        ran = random.Random()
        verify_code = ran.randint(100000, 999999)
        current_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        content = \
            f"""
尊敬的用户你好：
    你的验证码为{verify_code},请勿将验证码泄露于他人，此验证码15分钟内有效。
音乐风格迁移
{current_date}
        """
        try:
            send_mail(mail_addr, '音乐风格迁移验证码', content)
            user_mail_code[mail_addr] = dict(code=verify_code, time=time.time())
            data = dict(code=verify_code)
            msg = '验证码发送成功'
        except Exception:
            code = ResponseCode.existed_error
            msg = '验证码发送失败'
        finally:
            pass
    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result)


@app.route('/modify_passwd', methods=['POST'])
def user_change_password():
    """
    用户修改密码 body
    {
        "mail": "string 用户邮箱",
        "verify_code": "string 邮箱验证码"
        "password": "新密码"
    }
    :return:
    """
    code = ResponseCode.success
    msg = ''
    data = dict()
    body_data = request.get_json()
    mail_addr = body_data.get('mail')
    verify_code = body_data.get('verify_code')
    password = body_data.get('password')

    if mail_addr is None or verify_code is None or password is None:
        code = ResponseCode.param_missing
        msg = '参数缺失'

    user_verify_code_data = user_mail_code.get(mail_addr)
    # print(user_mail_code, mail_addr, verify_code, password)
    if user_verify_code_data is None:
        code = ResponseCode.db_not_found
        msg = '邮箱不正确'
    elif str(user_verify_code_data.get('code')) != str(verify_code):
        code = ResponseCode.param_error
        msg = '验证码不正确'
    elif int(time.time() - user_verify_code_data.get('time')) > 60 * 15:
        code = ResponseCode.param_error
        msg = '验证码已过期'

    if code == ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)

        try:
            cursor.execute("SELECT * FROM t_user WHERE mail = %s LIMIT 1", (mail_addr))
            current_user = cursor.fetchone()
            if current_user is None:
                code = ResponseCode.db_not_found
                msg = '邮箱不正确'
            else:
                cursor.execute("UPDATE t_user SET password=%s WHERE mail = %s", (password, mail_addr))
                db_conn.commit()
                session.clear()
                session['user_id'] = current_user.get('id')
                session['user_phone'] = current_user.get('phone')
                msg = '修改成功'
                data = True
        except db_conn.Error:
            code = ResponseCode.db_conn_error
            msg = '数据库连接错误'
        finally:
            cursor.close()

    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result)


@app.route('/modify_user_info', methods=['PUT'])
def modify_user_info():
    """
    用户修改个人信息,put请求，请求体位于body中，根据需要修改
    ```json
    {
        "user_id": "number,用户ID"
        "username": "string, 用户名",
        "password": "string,用户登录密码",
        "avatar": "string,用户头像，已base64编码"
        "avatar_url": "string,用户头像URL，已通过其它API上传文件后的URL"
    }
    ```
    :return: 修改成功返回新的用户个人信息，否则data域为空
    """
    user_id = session.get('user_id')
    body_data = request.get_json()
    username = body_data.get('username', 'User')
    password = body_data.get('password')
    avatar = body_data.get('avatar')
    avatar_url = body_data.get('avatar_url')
    if user_id is None:
        user_id = body_data.get('user_id')
    code = ResponseCode.success
    msg = ''
    userInfo = None

    db_conn = get_db()
    cursor = db_conn.cursor(pymysql.cursors.DictCursor)

    if user_id:
        try:
            if username:
                cursor.execute("UPDATE db_music_trans.t_user SET username = %s WHERE id = %s", (username, int(user_id)))
            if password:
                cursor.execute("UPDATE db_music_trans.t_user SET password = %s WHERE id = %s", (password, int(user_id)))
            if avatar:
                avatar_url = upload_image(avatar)
                cursor.execute("UPDATE db_music_trans.t_user SET avatar = %s WHERE id = %s", (avatar_url, int(user_id)))
            if avatar_url:
                cursor.execute("UPDATE db_music_trans.t_user SET avatar = %s WHERE id = %s", (avatar_url, int(user_id)))
            db_conn.commit()
            code = ResponseCode.success
            msg = '修改成功'
            cursor.execute(
                "SELECT id, phone,mail,username,avatar,created FROM db_music_trans.t_user WHERE id = %s",
                (int(user_id)))
            userInfo = cursor.fetchone()
            session.clear()
            if userInfo is not None:
                session['user_id'] = userInfo.get('id')
                session['user_phone'] = userInfo.get('phone')
            else:
                msg = '用户不存在'
        except db_conn.Error:
            db_conn.rollback()
            code = ResponseCode.db_conn_error
            msg = '数据库连接错误'
        except Exception:
            code = ResponseCode.param_error
            msg = '上传头像失败'
        finally:
            cursor.close()
    else:
        code = ResponseCode.db_not_found
        msg = '用户未登录'

    result = dict(code=code, data=userInfo, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


@app.route('/upload_single_image', methods=['POST'])
def upload_image_test():
    """
    以base64的形式上传图片，对于用户头像的上传可以使用该API，上传文件请使用/upload_files
    :return: data域中为访问图片的URL
    """
    body_data = request.get_json()
    base64_img = body_data.get('image')
    image_url = upload_image(base64_img)
    result = dict(url=image_url)
    return json.dumps(result)


@app.route('/upload_files', methods=['POST'])
def flask_upload_files_by_form():
    """
    上传多个文件，文件存在于form中
    :return: data域中为文件名及访问URL
    """
    code = ResponseCode.success
    msg = ''
    data = []

    try:
        for item in request.files.keys():
            file = request.files.get(item)
            file_url = upload_file(file, file.filename)
            file_dict = dict(file=file.filename, url=file_url, success=True)
            data.append(file_dict)
            print(item)
    except Exception:
        data.pop()
        code = ResponseCode.existed_error
        msg = '存在未上传成功的文件'
    finally:
        result = dict(code=code, data=data, msg=msg)
    return json.dumps(result)


@app.route('/instrument/upload', methods=['POST'])
def upload_single_instrument():
    """
    上传乐器，数据位于form中，需要字段为`name`,`name_image`,`audio`,`description`,`category`,`image`,
    前三个为文本类型，`image`为file类型

    返回数据中data域形式为
    {"id":"","name":"","image":"图片URL","description":"","category":""}
    :return:
    """
    code = ResponseCode.success
    msg = ''
    data = None
    name = ''
    description = ''
    category = ''
    image_url = ''
    model_url = ''
    name_image = ''
    audio = ''

    try:
        name = request.form['name']
        description = request.form['description']
        category = request.form['category']
        image = request.files['image']
        image_url = upload_file(image, image.filename)
        model = request.files.get('model')
        model_url = upload_file(model, model.filename)
        name_image = request.files.get('name_image')
        if name_image is not None:
            name_image = upload_file(name_image, name_image.filename)
        audio = request.files.get('audio')
        if audio is not None:
            audio = upload_file(audio, audio.filename)
    except KeyError:
        msg = '参数错误或缺失'
        code = ResponseCode.param_error
        pass
    except AttributeError:
        msg = '图片缺失'
        code = ResponseCode.param_missing

    if code is ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)
        try:
            cursor.execute(
                "INSERT INTO db_music_trans.t_instrument(`name`,`image`,`model`,`description`,`category`,"
                "`name_image`,`audio`)"
                "VALUES (%s,%s,%s,%s,%s,%s,%s)",
                (name, image_url, model_url, description, category, name_image, audio))
            db_conn.commit()
            cursor.execute("SELECT LAST_INSERT_ID() AS id")
            insert_id = cursor.fetchone().get('id')
            data = dict(id=insert_id, name=name, image=image_url, model=model_url, description=description,
                        category=category, name_image=name_image, audio=audio)
        except db_conn.Error:
            db_conn.rollback()
            code = ResponseCode.db_conn_error
            msg = '连接数据库错误'
            data = {}
            pass
        finally:
            cursor.close()

    msg = 'success'
    result = dict(code=code, msg=msg, data=data)
    return json.dumps(result)


def get_single_instrument_by_id(id):
    """
    获取特定ID的乐器信息，GET请求，参数位于URL中 id=<>
    :return: data域为乐器信息{id,name,description,image,category}
    """
    code = ResponseCode.success
    msg = 'success'
    data = {}

    try:
        id = int(id)
    except Exception:
        code = ResponseCode.param_error
        msg = '参数错误'

    if code is ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)

        try:
            cursor.execute("SELECT * FROM db_music_trans.t_instrument WHERE id = %s", (id))
            data = cursor.fetchone()
            if data is None:
                code = ResponseCode.db_not_found
                msg = '不存在相应数据'
        except db_conn.Error:
            code = ResponseCode.db_conn_error
            msg = '数据库连接错误'
        finally:
            cursor.close()

    result = dict(code=code, msg=msg, data=data)
    return json.dumps(result)


def search_instruments_by_name(instrument_name=None, instrument_category=None):
    """
    按名字/类别查找相应乐器，GET请求，参数name位于URL中
    :param instrument_category: 类别关键字
    :param instrument_name: 名字关键字
    :return: data域为所有匹配的乐器，数组形式
    """
    code = ResponseCode.success
    msg = ''
    data = []

    if (instrument_name is not None) and (instrument_category is None):
        exec_sql = "SELECT * FROM db_music_trans.t_instrument WHERE LOCATE(%s,`name`)>0"
        query_args = (instrument_name)
    elif instrument_category is not None and (instrument_name is None):
        exec_sql = "SELECT * FROM db_music_trans.t_instrument WHERE LOCATE(%s,`category`)>0"
        query_args = (instrument_category)
    else:
        exec_sql = "SELECT * FROM db_music_trans.t_instrument WHERE LOCATE(%s,`name`)>0 AND LOCATE(%s,`category`)>0"
        query_args = (instrument_name, instrument_category)

    db_conn = get_db()
    cursor = db_conn.cursor(pymysql.cursors.DictCursor)
    try:
        cursor.execute(exec_sql, query_args)
        data = cursor.fetchall()
    except db_conn.Error:
        code = ResponseCode.db_conn_error
        msg = '数据库连接错误'
    finally:
        cursor.close()

    msg = len(data)
    result = dict(code=code, msg=msg, data=data)
    return json.dumps(result)


def get_all_instruments():
    """
    获取所有的乐器
    :return: data域为乐器信息的数组
    """
    code = ResponseCode.success
    msg = 'success'
    data = []
    db_conn = get_db()
    cursor = db_conn.cursor(pymysql.cursors.DictCursor)

    try:
        cursor.execute("SELECT * FROM db_music_trans.t_instrument")
        data = cursor.fetchall()
    except db_conn.Error:
        code = ResponseCode.db_conn_error
        msg = '连接数据库错误'
    finally:
        cursor.close()

    msg = len(data)
    result = dict(code=code, msg=msg, data=data)
    return json.dumps(result)


@app.route('/instrument', methods=['GET'])
def get_instruments_by_arges():
    instrument_name = request.args.get('name')
    instrument_id = request.args.get('id')
    instrument_category = request.args.get('category')

    if instrument_name or instrument_category:
        return search_instruments_by_name(instrument_name, instrument_category)
    elif instrument_id:
        return get_single_instrument_by_id(instrument_id)
    else:
        return get_all_instruments()


@app.route('/instrument', methods=['DELETE'])
def delete_single_instrument():
    instrument_id = request.args.get('id')
    code = ResponseCode.success
    msg = 'success'

    if instrument_id is None:
        code = ResponseCode.param_missing
        msg = '缺失乐器ID参数'

    db_conn = get_db()
    cursor = db_conn.cursor(pymysql.cursors.DictCursor)
    if ResponseCode.success is code:
        try:
            cursor.execute("DELETE FROM db_music_trans.t_instrument WHERE `id` = %s", (instrument_id))
        except db_conn.Error:
            code = ResponseCode.db_conn_error
            msg = '数据库连接错误'
        finally:
            cursor.close()

    result = dict(code=code, msg=msg)
    return json.dumps(result)


@app.route('/music', methods=['POST'])
def post_single_music():
    """
    上传乐曲,所有数据存于form表单中
    name : Text 乐曲名
    artist : Text 作者
    genre : Text 体裁风格
    description : Text 乐曲简介
    file : File 乐曲文件
    instrument : List [{"name":"name:String","weight":weight:float}], 该乐曲演凑的乐曲及其权重
    :return: data域为该乐曲的上传信息
    """
    code = ResponseCode.success
    msg = ''
    mi = dict()
    try:
        mi['name'] = request.form['name']
        mi['artist'] = request.form['artist']
        mi['genre'] = request.form['genre']
        mi['description'] = request.form['description']
        mi['instrument'] = request.form['instrument']
        mi['instrument'] = json.loads(mi['instrument'])
        mi['image'] = request.form['image']
        file = request.files.get('file')
        if file is None:
            raise FileNotFoundError
        else:
            mi['file'] = upload_file(file, file.filename)
    except FileNotFoundError:
        code = ResponseCode.param_missing
        msg = '缺失乐曲文件'
    except Exception as e:
        print(e)
        code = ResponseCode.param_missing
        msg = '参数缺失'

    if code == ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)
        try:
            cursor.execute(
                "INSERT INTO db_music_trans.t_music(`name`,`image`, artist, genre, `description`, file_url) VALUES "
                "(%s,%s,%s,%s,%s,%s)",
                (mi['name'], mi['image'], mi['artist'], mi['genre'], mi['description'], mi['file']))
            db_conn.commit()
            cursor.execute("SELECT LAST_INSERT_ID() AS id FROM db_music_trans.t_music")
            mi['id'] = cursor.fetchone()['id']
            # 已收录的乐器
            instruments = list()
            for item in list(mi['instrument']):
                cursor.execute("SELECT `id`,`name` FROM db_music_trans.t_instrument WHERE `name` = %s", (item['name']))
                temp = cursor.fetchone()
                if temp is None:
                    msg = "未收录乐器{}".format(item['name'])
                    raise pymysql.err.Warning
                inst_id = temp['id']
                cursor.execute("INSERT INTO db_music_trans.t_music_instrument(music_id, instrument_id, weight) VALUES "
                               "(%s,%s,%s)",
                               (mi['id'], inst_id, item['weight']))

                instruments.append(dict(id=temp['id'], name=temp['name'], weight=item['weight']))
            mi['instrument'] = instruments
            db_conn.commit()
        except pymysql.Error:
            db_conn.rollback()
            code = ResponseCode.db_conn_error
            msg = "数据库链接错误"
        except pymysql.Warning:
            db_conn.rollback()
            code = ResponseCode.db_not_found
        finally:
            cursor.close()

    result = dict(code=code, data=mi, msg=msg)
    return json.dumps(result)


@app.route('/music_inst_type', methods=['GET'])
def get_music_list_by_inst_type():
    """
    获取某一类型乐器演凑的所有曲子
    URL 参数 ?type=<inst_type>
    :return: data域为乐曲列表
    """
    code = ResponseCode.success
    msg = ""
    data = []
    en_type = {''}

    inst_type = request.args.get('type')
    if inst_type is None:
        code = ResponseCode.param_missing
        msg = "缺失URL参数type"

    if code == ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)

        try:
            cursor.execute("SELECT t_music.* FROM t_music WHERE id IN "
                           "(SELECT t_mi.music_id AS id FROM t_music_instrument t_mi,t_instrument "
                           "WHERE t_mi.instrument_id=t_instrument.id AND t_instrument.category=%s)",
                           (inst_type))
            data = cursor.fetchall()
            msg = 'success'
        except pymysql.Error:
            code = ResponseCode.db_conn_error
            msg = "数据库连接错误"
        finally:
            cursor.close()

    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


@app.route('/music_id', methods=['GET'])
def get_music_info_by_id():
    """
    URL参数?id=<music_id>
    获取指定id的乐曲的详细信息，包括演凑乐器id等
    :return: data域为乐曲信息
    """
    code = ResponseCode.success
    msg = ''
    data = dict()

    music_id = request.args.get('id')
    if id is None:
        code = ResponseCode.param_missing
        msg = "缺少乐曲ID"

    if code == ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)

        try:
            cursor.execute("SELECT t_music.* FROM t_music WHERE id=%s", (music_id))
            data = cursor.fetchone()
            if data is not None:
                cursor.execute("SELECT * FROM t_music_instrument WHERE music_id=%s", (music_id))
                data['instruments'] = cursor.fetchall()
                msg = 'success'
            else:
                code = ResponseCode.db_not_found
                msg = "数据不存在"
        except pymysql.Error:
            code = ResponseCode.db_conn_error
            msg = "数据库连接错误"
        finally:
            cursor.close()

    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


@app.route('/music_all', methods=['GET'])
def get_all_music():
    """
    获取所有乐曲
    :return: data域为乐曲列表
    """
    code = ResponseCode.success
    msg = ""
    data = []

    db_conn = get_db()
    cursor = db_conn.cursor(pymysql.cursors.DictCursor)

    try:
        cursor.execute("SELECT * FROM t_music")
        data = cursor.fetchall()
        msg = 'success'
    except pymysql.Error:
        code = ResponseCode.db_conn_error
        msg = "数据库连接错误"
    finally:
        cursor.close()

    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


# 用户提交反馈信息
@app.route('/feedback', methods=['POST'])
def user_push_feedback():
    """
    用户提交反馈信息，需要登陆后操作，body数据如下
    {
        "user_id": "反馈用户ID，非必须，用户已登录的情况下无需该字段《number》",
        "type": "反馈类型《String》",
        "content": "反馈的内容《String》1000字以内"
    }
    :return:
    """
    code = ResponseCode.success
    msg = ''
    data = dict()
    body_data = request.get_json()
    user_id = session.get('user_id')
    if user_id is None:
        user_id = body_data.get('user_id')
    if user_id is None:
        code = ResponseCode.param_missing
        msg = '缺失用户ID'

    feedback_type = body_data.get('type')
    feedback_content = body_data.get('content')

    db_conn = get_db()
    cursor = db_conn.cursor(pymysql.cursors.DictCursor)

    if code == ResponseCode.success:
        try:
            cursor.execute("INSERT INTO t_customer_feedback(user_id, type, content) VALUES (%s,%s,%s)",
                           (user_id, feedback_type, feedback_content))
            db_conn.commit()
            cursor.execute("SELECT LAST_INSERT_ID() AS id FROM t_customer_feedback")
            data['id'] = cursor.fetchone().get('id')
            data['type'] = feedback_type
            data['content'] = feedback_content
            data['is_replied'] = False
            send_feedback_mail(user_id, feedback_type, feedback_content)
        except db_conn.Error:
            data = dict()
            db_conn.rollback()
            code = ResponseCode.db_conn_error
            msg = '数据库链接错误'
        finally:
            cursor.close()

    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result)


# 获取当前用户的所有反馈信息
@app.route('/my_feedback', methods=['GET'])
def get_my_feedback_list():
    """
    获取请求用户的所有反馈信息，无参数,
    测试时用户未登录的情况添加URL参数
    user_id=<userId,number>
    :return:
    """
    code = ResponseCode.success
    msg = ''
    data = list()

    user_id = session.get('user_id')
    if user_id is None:
        user_id = request.args.get('user_id')
        if user_id is None:
            code = ResponseCode.not_login
        msg = '用户未登录'

    if code == ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)
        try:
            cursor.execute("SELECT * FROM t_customer_feedback WHERE user_id=%s", (user_id))
            data = cursor.fetchall()
            msg = '查询成功'
        except db_conn.Error:
            code = ResponseCode.db_conn_error
            msg = '数据库连接错误'
        finally:
            cursor.close()

    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


@app.route('/all_feedback', methods=['GET'])
def get_all_feedback_list():
    """
    获取所有反馈信息,无参数返回全部
    添加参数is_replied = 1/0获取已回复/未回复的反馈信息，
    :return:
    """
    code = ResponseCode.success
    msg = ''
    data = list()

    is_replied = None
    try:
        is_replied = request.args.get('is_replied', type=int)
    except ValueError:
        code = ResponseCode.param_error
        msg = '参数解析错误'

    if code == ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)

        try:
            if is_replied is None:
                cursor.execute("SELECT * FROM t_customer_feedback WHERE TRUE")
                data = cursor.fetchall()
            else:
                is_replied = bool(is_replied)
                cursor.execute("SELECT * FROM t_customer_feedback WHERE is_replied=%s", is_replied)
                data = cursor.fetchall()
            msg = '查询成功'
        except db_conn.Error:
            code = ResponseCode.db_conn_error
            msg = '数据库连接错误'
        finally:
            cursor.close()

    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


@app.route('/reply_feedback', methods=['POST'])
def reply_one_feedback():
    """
    回复一个反馈信息 请求数据位于body格式如下
    {
        "id": "该反馈的唯一标识符id，必须",
        "reply": "回复内容，1000字以内"
    }
    :return:
    """
    code = ResponseCode.success
    msg = ''
    data = list()
    body_data = request.get_json()

    feedback_id = body_data.get('id')
    reply = body_data.get('reply')

    if feedback_id is None:
        code = ResponseCode.param_error
        msg = '缺少反馈ID'

    if code == ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)

        try:
            cursor.execute("UPDATE t_customer_feedback SET is_replied=TRUE,reply=%s,reply_time=CURRENT_TIMESTAMP() "
                           "WHERE id=%s", (reply, feedback_id))
            db_conn.commit()
            msg = '回复成功'
            cursor.execute("SELECT * FROM t_customer_feedback WHERE id=%s", (feedback_id))
            data = cursor.fetchone()
        except db_conn.Error:
            db_conn.rollback()
            code = ResponseCode.db_conn_error
            msg = '数据库连接错误'
        finally:
            cursor.close()

    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


@app.route('/start_trans', methods=['POST'])
def trans_music():
    """
    转换一首乐曲，数据位于body
    {
        "user_id": 用户ID
        "music_id": 音乐的ID，
        "instrument_id": 要转换成的乐器的ID
    }
    :return: data域包括
    {
        `id`            int unsigned auto_increment comment '转换后的乐曲ID',
        `origin_id`     int unsigned not null comment '原乐曲的ID',
        `instrument_id` int unsigned comment '转换所用的乐器的ID',
        `transed_url`   varchar(255) comment '转换后的乐曲文件存储URL',
    }
    """
    code = ResponseCode.success
    msg = ''
    data = dict()

    music_id = request.get_json().get('music_id')
    instrument_id = request.get_json().get('instrument_id')
    if music_id is None or instrument_id is None:
        code = ResponseCode.param_missing
        msg = '缺少必要参数，音乐ID或乐器ID'

    user_id = session.get('user_id')
    if user_id is None:
        user_id = request.get_json().get('user_id')
        user_id = int(user_id)

    if code == ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)

        try:
            cursor.execute("SELECT * FROM db_music_trans.t_music WHERE id=%s", (music_id))
            music = cursor.fetchone()
            if music is None:
                code = ResponseCode.db_not_found
                msg = '未查询到该乐器'
                print(msg)
            else:
                music_url = music.get('file_url')
                # TODO("乐曲转换代码")
                try:
                    url = trans_music_util(music_url, instrument_id)
                except Exception:
                    code = ResponseCode.existed_error
                    msg = '转换失败'
                    print(msg)
                    raise Exception

                cursor.execute("INSERT INTO t_transed_music(origin_id, instrument_id, transed_url) VALUES( %s, %s, %s)",
                               (music_id, instrument_id, url))
                db_conn.commit()
                cursor.execute("SELECT LAST_INSERT_ID() as id from t_transed_music")
                trans_music_id = cursor.fetchone().get("id")
                data = dict(id=trans_music_id, origin_id=music_id, instrument_id=instrument_id, transed_url=url)

                # 用户登录的情况下，添加历史记录
                if user_id is not None:
                    cursor.execute("INSERT INTO t_user_history(user_id, transed_id) VALUES (%s,%s)",
                                   (user_id, trans_music_id))
                    db_conn.commit()

        except (db_conn.Error, Exception):
            db_conn.rollback()
            code = ResponseCode.db_conn_error
            print(msg)
            msg = '数据库连接错误'
        finally:
            cursor.close()

    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


@app.route('/add_love', methods=['POST'])
def add_my_love():
    """
    用户添加收藏，数据位于body
    {
        "transed_id" : 转换后的乐曲的ID,
        "user_id": 非必须，登陆的情况下不需要该参数
    }
    :return: None
    """
    code = ResponseCode.success
    msg = ''
    data = dict()

    transed_id = request.get_json().get('transed_id')
    user_id = session.get("user_id")
    if user_id is None:
        user_id = request.get_json().get('user_id')
        if user_id is None:
            code = ResponseCode.not_login
            msg = '缺失用户id'

    if transed_id is None:
        code = ResponseCode.param_missing
        msg = '参数缺失'

    if code == ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)

        try:
            cursor.execute("INSERT INTO t_user_love(user_id, transed_id) VALUES (%s,%s)",
                           (user_id, transed_id))
            db_conn.commit()
            msg = '收藏成功'
            data = dict(success=True)
        except db_conn.Error:
            code = ResponseCode.db_conn_error
            msg = '数据库连接错误'
        finally:
            cursor.close()

    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result)


@app.route('/my_loves', methods=['GET'])
def get_user_loves_list():
    """
    获取用户的所有收藏，用户未登录，测试时加URL参数
        user_id=<user_id>
    :return: data域为收藏列表
    [{
        `id`            int  '转换后的乐曲ID',
        `origin_id`     int   '原乐曲的ID',
        `instrument_id` int   '转换所用的乐器的ID',
        `transed_url`   string  '转换后的乐曲文件存储URL',
        `created`       %Y-%m-%d %H:%M:%S  '转换时间',
        `origin` :  原始乐曲的信息
        {
            `id`          int  '歌曲ID',
            `name`        string '乐曲名',
            `artist`      string  '乐曲作者',
            `genre`       string  '体裁，风格',
            `description` string  '对该乐曲的简洁信息',
            `file_url`    string  '乐曲文件存储URL',
            `created_at`  string '创建时间',
        },
        `instrument`: 转换所用的乐器
        {
            `id`          int  '乐器ID',
            `name`         '乐器名',
            `image`       '图片URL',
            `model`       '乐器3维模型的访问URL',
            `description` '描述',
            `category`    '类别',
        }
    }]
    """
    code = ResponseCode.success
    msg = ''
    data = list()
    user_id = session.get('user_id')
    if user_id is None:
        user_id = request.args.get('user_id')
        if user_id is None:
            code = ResponseCode.not_login
            msg = '缺失用户ID'

    if code == ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)

        try:
            cursor.execute("SELECT tm.* FROM db_music_trans.t_transed_music tm, t_user_love ul "
                           "WHERE tm.id = ul.transed_id AND ul.user_id = %s;",
                           (user_id))
            data = cursor.fetchall()
            for item in data:
                cursor.execute("SELECT * FROM t_music WHERE id = %s",
                               (item.get('origin_id')))
                origin = cursor.fetchone()
                cursor.execute("SELECT * FROM t_instrument WHERE id = %s",
                               (item.get('instrument_id')))
                instrument = cursor.fetchone()
                item['origin'] = origin
                item['instrument'] = instrument
                msg = '查询成功'

        except db_conn.Error:
            code = ResponseCode.db_conn_error
            msg = '数据库连接错误'
        finally:
            cursor.close()

    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


@app.route('/delete_love', methods=['DELETE'])
def delete_my_love_item():
    """
    删除收藏
    数据位于URL参数中
    ?user_id = <> 用户ID，已登陆的情况下不需要
    &transed_id = <> 转换后的乐曲的ID
    :return:
    """
    code = ResponseCode.success
    msg = ''
    data = True

    user_id = session.get('user_id')
    if user_id is None:
        user_id = request.args.get('user_id')
        if user_id is None:
            code = ResponseCode.not_login
            msg = '缺失用户ID'

    transed_id = request.args.get('transed_id')
    if transed_id is None:
        code = ResponseCode.param_missing
        msg = '缺失转换后的乐曲的ID'

    if code == ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)

        try:
            cursor.execute("DELETE FROM t_user_love WHERE user_id = %s AND transed_id = %s",
                           (user_id, transed_id))
            db_conn.commit()
            data = True
        except db_conn.Error:
            db_conn.rollback()
            data = False
            code = ResponseCode.db_conn_error
            msg = '数据库连接错误'
        finally:
            cursor.close()

    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result)


@app.route('/my_history', methods=['GET'])
def get_my_trans_history_list():
    """
    获取用户转换的历史记录
    用户未登录的情况下需要URL参数
    user_id=《》
    :return:
    """
    code = ResponseCode.success
    msg = ''
    data = list()

    user_id = session.get('user_id')
    if user_id is None:
        user_id = request.args.get('user_id')
        if user_id is None:
            code = ResponseCode.not_login
            msg = '缺失用户ID'

    if code == ResponseCode.success:
        db_conn = get_db()
        cursor = db_conn.cursor(pymysql.cursors.DictCursor)

        try:
            cursor.execute("SELECT tm.* FROM db_music_trans.t_transed_music tm, t_user_history uh "
                           "WHERE tm.id = uh.transed_id AND uh.user_id = %s;",
                           (user_id))
            data = cursor.fetchall()
            if data is not None:
                for item in data:
                    cursor.execute("SELECT * FROM t_music WHERE id = %s",
                                   (item.get('origin_id')))
                    origin = cursor.fetchone()
                    cursor.execute("SELECT * FROM t_instrument WHERE id = %s",
                                   (item.get('instrument_id')))
                    instrument = cursor.fetchone()
                    item['origin'] = origin
                    item['instrument'] = instrument
                    msg = '查询成功'
        except db_conn.Error:
            code = ResponseCode.db_conn_error
            msg = '数据库连接错误'
        finally:
            cursor.close()

    result = dict(code=code, data=data, msg=msg)
    return json.dumps(result, cls=DatetimeEncoder)


if __name__ == '__main__':
    app.run(port=5000, debug=False, host='0.0.0.0')