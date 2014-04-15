#include "CrashHandler.h"


/************************************************************************/
/* CrashHandler                                                         */
/************************************************************************/
CrashHandler* CrashHandler::instance()
{
    static CrashHandler globalHandler;
    return &globalHandler;
}
 
CrashHandler::CrashHandler()
{
}
 
CrashHandler::~CrashHandler()
{
}
 
void CrashHandler::setReportCrashesToSystem(bool report)
{
    Q_UNUSED(report);
}
 
bool CrashHandler::writeMinidump()
{
    return true;
}
 
void CrashHandler::Init( const QString& reportPath )
{
    Q_UNUSED(reportPath);
}
