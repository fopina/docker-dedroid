FROM anapsix/alpine-java:8 as sdkbuilder

# could use ADD but it always downloads the 137M to check the digest..
# cool, but for smaller downloads...
RUN apk add --no-cache curl
RUN curl -sL https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip -o /sdktools.zip
RUN mkdir -p /sdk/licenses
WORKDIR /sdk
RUN unzip -q /sdktools.zip
RUN echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > /sdk/licenses/android-sdk-license
RUN /sdk/tools/bin/sdkmanager "build-tools;26.0.1"

FROM anapsix/alpine-java:8

RUN apk add --no-cache curl
RUN mkdir /dedroid/
RUN curl -sL https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.2.4.jar > /dedroid/apktool.jar
RUN curl -sL https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool > /dedroid/apktool
RUN chmod a+x /dedroid/apktool
COPY --from=sdkbuilder /sdk/build-tools/26.0.1/apksigner \
					   /sdk/build-tools/26.0.1/lib/apksigner.jar \
					   /sdk/build-tools/26.0.1/zipalign \
					   /dedroid/
COPY --from=sdkbuilder /sdk/build-tools/26.0.1/lib64/libc++.so /lib64/
COPY entrypoint.sh /entrypoint.sh
COPY helper.tmpl /helper.tmpl
COPY allinone /dedroid/allinone
ENV PATH=/dedroid/:$PATH
RUN mkdir /work
WORKDIR /work
ENTRYPOINT ["/entrypoint.sh"]