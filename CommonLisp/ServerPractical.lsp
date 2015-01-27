(ql:quickload :usocket)

(defun tcp-server (port)
  (let ((socket (usocket:socket-listen usocket:*wildcard-host*
				       port
				       :reuse-address t)))
    (unwind-protect
	 (progn
	   (format *standard-output* "Waiting for input on ~A~%" socket)
	   (usocket:wait-for-input socket)
	   (let* ((connection (usocket:socket-accept socket))
		 (stream (usocket:socket-stream connection)))
	     (format *standard-output* "Connection made to client~%")
	     (handle-request stream)))
      (progn
	(format *standard-output* "Closing socket~%")
	(usocket:socket-close socket)))))

(defun handle-request (stream)
  (let ((line (read-line stream)))
    (format *standard-output* "You said: ~S~%" line)
    (force-output stream)))

(defun tcp-test-client (port)
  (let ((conn (usocket:socket-connect usocket:*wildcard-host* port)))
    (format (usocket:socket-stream conn) "Hello World!~%")
    (force-output (usocket:socket-stream conn))))

