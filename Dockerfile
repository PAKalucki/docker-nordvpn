FROM alpine:3.17

ENV username user
ENV password pass
ENV protocol udp

EXPOSE 1194/udp

ADD https://downloads.nordcdn.com/configs/files/ovpn_legacy/servers/al18.nordvpn.com.udp1194.ovpn /etc/openvpn/ovpn_udp/al18.nordvpn.com.udp1194.ovpn
ADD https://downloads.nordcdn.com/configs/files/ovpn_legacy/servers/al18.nordvpn.com.tcp443.ovpn /etc/openvpn/ovpn_tcp/al18.nordvpn.com.tcp443.ovpn

RUN apk add --update curl openvpn iptables openvpn-auth-pam && \
    sed -i 's/auth-user-pass/auth-user-pass \/etc\/openvpn\/auth/g' /etc/openvpn/ovpn_udp/*.ovpn && \
    sed -i 's/auth-user-pass/auth-user-pass \/etc\/openvpn\/auth/g' /etc/openvpn/ovpn_tcp/*.ovpn && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
CMD ["--help"]