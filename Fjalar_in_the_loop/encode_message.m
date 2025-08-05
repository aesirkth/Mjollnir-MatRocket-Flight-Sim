function output_buf=encode_message(msg)
    % Serialize the message to a byte array
    msg_buf = uint8(SerializeToString(msg));  % You need to implement or use this

    % Build the output buffer
    alignment_byte = uint8(0x33);
    msg_length = length(msg_buf);
    output_buf = uint8([alignment_byte, msg_length, msg_buf]);

    % Calculate CRC16
    crc = crc16(0x01011, 0x35, output_buf);

   % Append CRC (little endian)
    crc_low = bitand(crc, hex2dec('00FF'));
    crc_high = bitand(bitshift(crc, -8), hex2dec('00FF'));
    output_buf = [uint8(output_buf), uint8([crc_low, crc_high])];
end