;; Mysql specfic config


(defun speedy-mysql-config ()
  "Override MySQL default Config"
  (interactive)
  ((setq sql-port 3307)
   (setq sql-user "java@%")
   (setq sql-server "11.2.1.255")
   (setq sql-database "speedy_java")))


(defun cnp-mysql-config ()
  "Override MySQL default Config"
  (interactive)
  ((setq sql-port 3306)
   (setq sql-user "cnp")
   (setq sql-server "localhost")
   (setq sql-database "cnp")))
