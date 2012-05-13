#' Limit virtual memory
#' 
#' Limits the maximum size of the process's virtual memory (address
#' space) in bytes.
#' 
#' The maximum size of the process's virtual memory (address space)
#' in bytes. This limit affects calls to brk(2), mmap(2) and
#' mremap(2), which fail with the error ENOMEM upon exceeding this
#' limit. Also automatic stack expansion will fail (and generate a
#' SIGSEGV that kills the process if no alternate stack has been
#' made available via sigaltstack(2)). Since the value is a long,
#' on machines with a 32-bit long either this limit is at most 2
#' GiB, or this resource is unlimited.
#' 
#' @param softlim soft limit in bytes.
#' @param hardlim hard limit in bytes
#' @param pid id of the target process.
#' @export
#' @family rlimit
rlimit_as <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_as', hardlim, softlim, pid);
}

#' Limit core size.
#' 
#' Maximum size of core file. When 0 no core dump files are
#' created. When nonzero, larger dumps are truncated to this size.
#' 
#' @param hardlim size
#' @param softlim size
#' @param pid id of the target process
#' @export
#' @family rlimit
rlimit_core <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_core', hardlim, softlim, pid);
}

#' Limit CPU time
#' 
#' CPU time limit in seconds. When the process reaches the soft
#' limit, it is sent a SIGXCPU signal.
#' 
#' CPU time limit in seconds. When the process reaches the soft
#' limit, it is sent a SIGXCPU signal. The default action for this
#' signal is to terminate the process. However, the signal can be
#' caught, and the handler can return control to the main program.
#' If the process continues to consume CPU time, it will be sent
#' SIGXCPU once per second until the hard limit is reached, at
#' which time it is sent SIGKILL. (This latter point describes
#' Linux behavior. Implementations vary in how they treat
#' rocesses which continue to consume CPU time after reaching the
#' soft limit. Portable applications that need to catch this
#' signal should perform an orderly termination upon first receipt
#' of SIGXCPU.)
#' 
#' @param hardlim cpu time in seconds
#' @param softlim cpu time in seconds
#' @param pid id of the target process
#' @export
#' @family rlimit
rlimit_cpu <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_cpu', hardlim, softlim, pid);
}

#' Limit data segment
#' 
#' The maximum size of the process's data segment (initialized
#' data, uninitialized data, and heap).
#' 
#' The maximum size of the process's data segment (initialized
#' data, uninitialized data, and heap). This limit affects calls
#' to brk(2) and sbrk(2), which fail with the error ENOMEM upon
#' encountering the soft limit of this resource.
#' 
#' @param hardlim size
#' @param softlim size
#' @param pid id of the target process
#' @export
#' @family rlimit
rlimit_data <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_data', hardlim, softlim, pid);
}


#' Limit size of files
#' 
#' The maximum size of files that the process may create.
#' 
#' The maximum size of files that the process may create. Attempts
#' to extend a file beyond this limit result in delivery of a
#' SIGXFSZ signal. By default, this signal terminates a process,
#' but a process can catch this signal instead, in which case the
#' relevant system call (e.g., write(2), truncate(2)) fails with
#' the error EFBIG.
#' 
#' @param hardlim size
#' @param softlim size
#' @param pid id of the target process
#' @export
#' @family rlimit
rlimit_fsize <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_fsize', hardlim, softlim, pid);
}



#' Limit locked memory
#' 
#' The maximum number of bytes of memory that may be locked into
#' RAM.
#' 
#' The maximum number of bytes of memory that may be locked into
#' RAM. In effect this limit is rounded down to the nearest
#' multiple of the system page size. This limit affects mlock(2)
#' and mlockall(2) and the mmap(2) MAP_LOCKED operation. Since
#' Linux 2.6.9 it also affects the shmctl(2) SHM_LOCK operation,
#' where it sets a maximum on the total bytes in shared memory
#' segments (see shmget(2)) that may be locked by the real user ID
#' of the calling process. The shmctl(2) SHM_LOCK locks are
#' accounted for separately from the per-process memory locks
#' established by mlock(2), mlockall(2), and mmap(2) MAP_LOCKED; a
#' process can lock bytes up to this limit in each of these two
#' categories. In Linux kernels before 2.6.9, this limit
#' controlled the amount of memory that could be locked by a
#' privileged process. Since Linux 2.6.9, no limits are placed on
#' the amount of memory that a privileged process may lock, and
#' this limit instead governs the amount of memory that an
#' unprivileged process may lock.
#' 
#' @param hardlim number of bytes
#' @param softlim number of bytes
#' @param pid id of the target process
#' @export
#' @family rlimit
rlimit_memlock <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_memlock', hardlim, softlim, pid);
}


#' Limit user message queue
#' 
#' Specifies the limit on the number of bytes that can be allocated
#' for POSIX message queues for the real user ID of the calling
#' process.
#' 
#' Specifies the limit on the number of bytes that can be allocated
#' for POSIX message queues for the real user ID of the calling
#' process. This limit is enforced for mq_open(3). Each message
#' queue that the user creates counts (until it is removed) against
#' this limit according to the formula:
#' 
#' bytes = attr.mq_maxmsg * sizeof(struct msg_msg *) +
#' attr.mq_maxmsg * attr.mq_msgsize
#' 
#' where attr is the mq_attr structure specified as the fourth
#' argument to mq_open(3).
#' 
#' The first addend in the formula, which includes sizeof(struct
#' msg_msg *) (4 bytes on Linux/i386), ensures that the user cannot
#' create an unlimited number of zero-length messages (such
#' messages nevertheless each consume some system memory for
#' bookkeeping overhead).
#' 
#' @param hardlim number of bytes
#' @param softlim number of bytes
#' @param pid id of the target process
#' @export
#' @family rlimit
rlimit_msgqueue <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_msgqueue', hardlim, softlim, pid);
}

#' Limit nice value.
#' 
#' Specifies a ceiling to which the process's nice value can be
#' raised using setpriority(2) or nice(2).
#' 
#' Specifies a ceiling to which the process's nice value can be
#' raised using setpriority(2) or nice(2). The actual ceiling for
#' the nice value is calculated as 20 - rlim_cur. (This
#' strangeness occurs because negative numbers cannot be specified
#' as resource limit values, since they typically have special
#' meanings. For example, RLIM_INFINITY typically is the same as
#' -1.)
#' 
#' @param hardlim priority value between -20 and 20
#' @param softlim priority value between -20 and 20
#' @param pid id of the target process
#' @export
#' @family rlimit
rlimit_nice <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_nice', hardlim, softlim, pid);
}

#' Limit file descriptors
#' 
#' Specifies a value one greater than the maximum file descriptor
#' number that can be opened by this process.
#' 
#' Specifies a value one greater than the maximum file descriptor
#' number that can be opened by this process. Attempts (open(2),
#' pipe(2), dup(2), etc.) to exceed this limit yield the error
#' EMFILE. (Historically, this limit was named RLIMIT_OFILE on
#' BSD.)
#' 
#' @param hardlim number greater than 1
#' @param softlim number greater than 1
#' @param pid id of the target process
#' @export
#' @family rlimit
rlimit_nofile <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_nofile', hardlim, softlim, pid);
}


#' Limit number of processes
#' 
#' The maximum number of processes (or, more precisely on Linux,
#' threads) that can be created for the real user ID.
#' 
#' The maximum number of processes (or, more precisely on Linux,
#' threads) that can be created for the real user ID of the calling
#' process. Upon encountering this limit, fork(2) fails with the
#' error EAGAIN.
#' 
#' @param hardlim number greater than 1
#' @param softlim number greater than 1
#' @param pid id of the target process
#' @export
#' @family rlimit
rlimit_nproc <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_nproc', hardlim, softlim, pid);
}


#' Limit real-time priority
#' 
#' Specifies a ceiling on the real-time priority
#' 
#' Specifies a ceiling on the real-time priority that may be set
#' for this process using sched_setscheduler(2) and
#' sched_setparam(2).
#' 
#' @param hardlim real time priority value
#' @param softlim real time priority value
#' @param pid id of the target process
#' @export
#' @family rlimit
rlimit_rtprio <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_rtprio', hardlim, softlim, pid);
}


#' Limit real-time cpu
#' 
#' Specifies a limit (in microseconds) on the amount of CPU time
#' that a process scheduled under a real-time scheduling policy may
#' consume without making a blocking system call.
#' 
#' Specifies a limit (in microseconds) on the amount of CPU time
#' that a process scheduled under a real-time scheduling policy may
#' consume without making a blocking system call. For the purpose
#' of this limit, each time a process makes a blocking system call,
#' the count of its consumed CPU time is reset to zero. The CPU
#' time count is not reset if the process continues trying to use
#' the CPU but is preempted, its time slice expires, or it calls
#' sched_yield(2).

#' Upon reaching the soft limit, the process is sent a SIGXCPU
#' signal. If the process catches or ignores this signal and
#' continues consuming CPU time, then SIGXCPU will be generated
#' once each second until the hard limit is reached, at which point
#' the process is sent a SIGKILL signal.

#' The intended use of this limit is to stop a runaway real-time
#' process from locking up the system.
#' 
#' @param hardlim time in microsec
#' @param softlim time in microsec
#' @param pid id of the target process
#' @export
#' @family rlimit
rlimit_rttime <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_rttime', hardlim, softlim, pid);
}


#' Limit signal queue
#' 
#' Specifies the limit on the number of signals that may be queued
#' for the real user ID of the calling process. 
#' 
#' Specifies the limit on the number of signals that may be queued
#' for the real user ID of the calling process. Both standard and
#' real-time signals are counted for the purpose of checking this
#' limit. However, the limit is only enforced for sigqueue(3); it
#' is always possible to use kill(2) to queue one instance of any
#' of the signals that are not already queued to the process.
#' 
#' @param hardlim number of signals
#' @param softlim number of signals
#' @param pid id of the target process
#' @export
#' @family rlimit
rlimit_sigpending <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_sigpending', hardlim, softlim, pid);
}


#' Limit stack size.
#' 
#' Limits the maximum size of the process stack, in bytes.
#' 
#' The maximum size of the process stack, in bytes. Upon reaching
#' this limit, a SIGSEGV signal is generated. To handle this
#' signal, a process must employ an alternate signal stack
#' (sigaltstack(2)).

#' Since Linux 2.6.23, this limit also determines the amount of
#' space used for the process's command-line arguments and
#' environment variables; for details, see execve(2).
#' 
#' @param hardlim size of stack
#' @param softlim size of stack
#' @param pid id of the target process
#' @export
#' @family rlimit
rlimit_stack <- function(hardlim, softlim=hardlim, pid = 0){
	if(missing(hardlim)) hardlim <- NULL;
	rlimit_wrapper('rlimit_stack', hardlim, softlim, pid);
}


rlimit_wrapper <- function(resource, hardlim = NULL, softlim = NULL, pid = 0){
	if(is.null(hardlim)) {
		hardlim <- -999;
	} 
	if(is.null(softlim)) {
		softlim <- -999;
	}
	pid <- as.integer(pid);	
	hardlim <- as.integer(hardlim);
	softlim <- as.integer(softlim);
	ret <- integer(1);
	output <- .C(resource, ret, hardlim, softlim, pid, PACKAGE="rApparmor")
	if(output[[1]] != 0) stop("Failed to set ", resource, "\nError: ", output[[1]]);	
	invisible();	
}