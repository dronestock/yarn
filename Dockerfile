FROM ccr.ccs.tencentyun.com/storezhang/alpine:3.16.2


LABEL author="storezhang<华寅>" \
    email="storezhang@gmail.com" \
    qq="160290688" \
    wechat="storezhang" \
    description="Drone持续集成Node插件，支持测试、依赖管理、编译、打包等常规功能"


# 复制文件
COPY node /bin


# 模块存储目录
ENV MODULE_PATH /var/lib/node
# 修复安装其它模块时报SSL Provider错误
ENV NODE_OPTIONS --openssl-legacy-provider
# Pnpm模块存储路径
ENV XDG_DATA_HOME /var/lib/node


RUN set -ex \
    \
    \
    \
    # 安装依赖库
    && apk update \
    # 安装Node.js主体程序
    && apk --no-cache --update add nodejs \
    # 安装Npm依赖管理
    && apk --no-cache --update add npm \
    # 加速Npm
    && npm config set registry https://registry.npmmirror.com \
    \
    # 安装Pnpm依赖管理
    && npm install --global pnpm \
    \
    # 安装Yarn依赖管理
    && npm install --global yarn \
    # 加速Yarn
    && yarn config set registry https://npmmirror.com \
    && yarn config set sass_binary_site https://npmmirror.com/mirrors/node-sass/ \
    && yarn config set phantomjs_cdnurl https://cdn.npmmirror.com/binaries/phantomjs \
    && yarn config set electron_mirror https://cdn.npmmirror.com/binaries/electron/ \
    && yarn config set sqlite3_binary_host_mirror https://foxgis.oss-cn-shanghai.aliyuncs.com/ \
    && yarn config set chromedriver_cdnurl https://cdn.npmmirror.com/binaries/chromedriver \
    && yarn config set cache-folder ${MODULE_PATH} \
    \
    \
    \
    # 增加执行权限
    && chmod +x /bin/node \
    \
    \
    \
    && rm -rf /var/cache/apk/*


# 执行命令
ENTRYPOINT /bin/node
